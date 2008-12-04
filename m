From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Dec 2008 13:44:55 +0000
Subject: [PATCH 00/03] sh: CONFIG_PM and CONFIG_CPU_IDLE
Message-Id: <20081204134455.21168.38196.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

CONFIG_PM and CONFIG_CPU_IDLE:

[PATCH 01/03] sh: move the hp6xx pm code
[PATCH 02/03] sh: allow CONFIG_PM
[PATCH 03/03] sh: allow CONFIG_CPU_IDLE

These patches allow SuperH users to select CONFIG_PM and
CONFIG_CPU_IDLE. Suspend and hibernation are however not
allowed by default, platforms wanting such support should
use ARCH_SUSPECT_POSSIBLE and ARCH_HIBERNATION_POSSIBLE.

The not-so-generic pm code used by hp6xx is moved in next
to the rest of the hp6xx pm code.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                |   19 +++++---
 arch/sh/boards/mach-hp6xx/pm.c |   78 +++++++++++++++++++++++++++++++++++
 arch/sh/include/asm/pm.h       |   17 -------
 arch/sh/kernel/Makefile_32     |    1 
 arch/sh/kernel/Makefile_64     |    1 
 arch/sh/kernel/pm.c            |   88 ----------------------------------------
 6 files changed, 89 insertions(+), 115 deletions(-)
