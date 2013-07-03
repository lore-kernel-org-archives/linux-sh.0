From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 03 Jul 2013 12:29:41 +0000
Subject: Re: [PATCH 00/08] ARM: shmobile: EMEV2 and KZM9D update
Message-Id: <201307031429.41711.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20130702092725.32066.54861.sendpatchset@w520>
In-Reply-To: <20130702092725.32066.54861.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 02 July 2013, Magnus Damm wrote:
> ARM: shmobile: EMEV2 and KZM9D update
> 
> [PATCH 01/08] ARM: shmobile: Remove unused EMEV2/KZM9D early console
> [PATCH 02/08] ARM: shmobile: Update KZM9D dts command line
> [PATCH 03/08] ARM: shmobile: Make EMEV2 platform devices more compact
> [PATCH 04/08] ARM: shmobile: Add GIO to EMEV2 dtsi
> [PATCH 05/08] ARM: shmobile: Use DT for GIC on EMEV2 and KZM9D
> [PATCH 06/08] ARM: shmobile: Use DT for SMP on EMEV2 and KZM9D
> [PATCH 07/08] ARM: shmobile: EMEV2 map_io update
> [PATCH 08/08] ARM: shmobile: Disconnect EMEV2 SMP code from clocks
> 
> Several minor updates for the EMEV2 SoC and the KZM9D board:
> - Get rid of early console - the 8250-em driver does not support it
> - Update command line in DTS and remove old cruft
> - Make the EMEV2 platform devices more compact
> - Add GIO device nodes to the EMEV2 dtsi
> - Use DT for GIC and SMP for both regular KZM9D board code and DT
> - Reduce the size of the EMEV2 map_io - SCU is still however needed
> - Allow EMEV2 SMP to operate without legacy clock bits

Looks all good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
