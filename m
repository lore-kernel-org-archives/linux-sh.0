From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 10 Jun 2013 15:00:22 +0000
Subject: Re: [PATCH 00/03] ARM: shmobile: Remove legacy memory bits
Message-Id: <201306101700.22787.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20130610094638.20803.18484.sendpatchset@w520>
In-Reply-To: <20130610094638.20803.18484.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Monday 10 June 2013, Magnus Damm wrote:
> ARM: shmobile: Remove legacy memory bits
> 
> [PATCH 01/03] ARM: shmobile: Enable ARM_PATCH_PHYS_VIRT
> [PATCH 02/03] ARM: shmobile: Remove MEMORY_START/SIZE
> [PATCH 03/03] ARM: shmobile: Remove mach/memory.h
> 
> Now when all users are gone this series removes the legacy memory code
> and enables CONFIG_ARM_PATCH_PHYS_VIRT. Depends on the following code:
> 
> [PATCH v2] ARM: shmobile: uImage load address rework
> [PATCH] ARM: shmobile: Rework sh7372 sleep code to use virt_to_phys()
> [PATCH 00/06] ARM: shmobile: SMP virt_to_phys() conversion
> [PATCH 00/02] ARM: shmobile: romImage update
> 
> The romImage series above still needs to be updated.
> 
> This is the final bit of code not to rely on CONFIG_MEMORY_START/SIZE
> which in turn is one component that we need for ARCH_MULTIPLATFORM.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Looks all good to me.

	Arnd
