# Setup Specialized Agents for Antigravity IDE (Kiddora)

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

$agents = @(
    @{ Name = "product_owner"; Skill = "product-owner" },
    @{ Name = "project_manager"; Skill = "project-manager" },
    @{ Name = "scrum_master"; Skill = "scrum-master" },
    @{ Name = "tech_lead"; Skill = "tech-lead" },
    @{ Name = "business_analyst"; Skill = "business-analyst" },
    @{ Name = "ui_ux_designer"; Skill = "ui-ux-designer" },
    @{ Name = "flutter_core_dev"; Skill = "flutter-core-dev" },
    @{ Name = "backend_dev"; Skill = "backend-dev" },
    @{ Name = "qa_tester"; Skill = "qa-tester" },
    @{ Name = "code_reviewer"; Skill = "code-reviewer" },
    @{ Name = "security_auditor"; Skill = "security-auditor" },
    @{ Name = "devops_infra"; Skill = "devops-infra" }
)

$toolsBlock = @"
tools:
  - view_file
  - list_dir
  - grep_search
  - find_by_name
  - search_web
  - read_url_content
  - send_message
  - schedule
  - invoke_subagent
  - manage_subagents
  - write_to_file
  - replace_file_content
  - multi_replace_file_content
  - run_command
  - ask_question
mainAgent: true
subagent: true
commandExecutionPolicy: auto
"@

$pluginJsonContent = @"
{
  "name": "kiddora-agents",
  "displayName": "Kiddora Specialized Agents",
  "version": "1.0.0",
  "description": "12 Specialized Sub-Agents for Kiddora (PO, PM, Scrum Master, Tech Lead, BA, UI/UX, Flutter Dev, Backend Dev, QA Tester, Code Reviewer, Security Auditor, DevOps)",
  "author": {
    "name": "Kiddora Team"
  }
}
"@

$targetDirs = @(
    "C:\Projects\kiddora\.agents\plugins\kiddora-agents",
    "C:\Users\Admin\.gemini\config\plugins\kiddora-agents"
)

foreach ($baseDir in $targetDirs) {
    $agentsDir = Join-Path $baseDir "agents"
    if (-not (Test-Path $agentsDir)) {
        New-Item -ItemType Directory -Path $agentsDir -Force | Out-Null
    }
    
    $pluginJsonPath = Join-Path $baseDir "plugin.json"
    [System.IO.File]::WriteAllText($pluginJsonPath, $pluginJsonContent, $utf8NoBom)
}

foreach ($ag in $agents) {
    $skillFile = "C:\Projects\kiddora\.agents\skills\$($ag.Skill)\SKILL.md"
    if (-not (Test-Path $skillFile)) {
        Write-Warning "Skill file not found: $skillFile"
        continue
    }

    $rawContent = [System.IO.File]::ReadAllText($skillFile, [System.Text.Encoding]::UTF8)
    
    $desc = "Specialized Sub-Agent for Kiddora"
    if ($rawContent -match 'description:\s*"([^"]+)"') {
        $desc = $matches[1]
    }
    elseif ($rawContent -match "description:\s*'([^']+)'") {
        $desc = $matches[1]
    }

    $body = $rawContent
    if ($rawContent -match "(?s)^---\r?\n.*?\r?\n---\r?\n(.*)$") {
        $body = $matches[1]
    }

    $header = @"
---
name: $($ag.Name)
description: "$desc"
$toolsBlock
---

"@

    $finalContent = $header + $body

    foreach ($baseDir in $targetDirs) {
        $outFile = Join-Path $baseDir "agents\$($ag.Name).md"
        [System.IO.File]::WriteAllText($outFile, $finalContent, $utf8NoBom)
        Write-Host "Generated agent file: $outFile"
    }
}

Write-Host "All 12 specialized agents configured with correct UTF-8!"
