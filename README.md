# Server Health Check

A Bash script that reports the health of a Linux server — disk usage,
memory, system load, and the processes using the most memory — and
warns when disk usage crosses a set threshold.

## How to run

    chmod +x health-check.sh
    ./health-check.sh

The `chmod +x` step is required because a new file in Linux has no
execute permission by default. Without it the script fails with
"Permission denied", even though the filename ends in `.sh`.

## What it checks

- Disk usage on the root filesystem
- Memory: total, used, and available RAM
- System uptime and load average
- Top 5 processes by memory usage
- Warns when disk usage goes above 80 percent
- Appends every run to `health.log` with a timestamp

## Sample output

    ===== Server Health Report =====
    Hostname : Javeria
    Date     : Sat Aug 22 17:56:07 PKT 2026
    ----- Disk Usage -----
    Filesystem      Size  Used Avail Use% Mounted on
    /dev/sdd       1007G  1.3G  955G   1% /
    ----- Health Check -----
    Disk usage is 1%
    OK: disk usage is within limits

## What I learned

- `df -h`, `free -h`, and `uptime` are the first commands to run when
  checking a server, and `-h` makes the sizes readable
- A pipe `|` sends the output of one command into the next, so
  `df -h / | awk 'NR==2 {print $5}' | tr -d '%'` narrows a full report
  down to a single number
- `$( )` runs a command and stores its result in a variable
- `>` overwrites a file while `>>` adds to the end of it, so logs
  always use `>>`
- Bash comparisons use `-gt` and `-lt` instead of `>` and `<`, because
  `>` would be treated as a redirect
- Spacing matters in Bash: `THRESHOLD=80` works but `THRESHOLD = 80`
  does not, and `[ ]` needs spaces inside the brackets
