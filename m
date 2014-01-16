From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 16 Jan 2014 10:38:32 +0000
Subject: Re: [PATCH] ARM: shmobile: compile drivers/sh for CONFIG_ARCH_SHMOBILE_MULTI
Message-Id: <52D7B6A8.9000302@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1389367095-7760-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1389367095-7760-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 15/01/14 19:46, Laurent Pinchart wrote:
> Hi Simon,
>
> On Wednesday 15 January 2014 08:55:05 Simon Horman wrote:
>> On Tue, Jan 14, 2014 at 01:56:16PM +0000, Ben Dooks wrote:
>>> If the kernel is built to support multi-arm configurmation with shmobile
>>> support built in, then the drivers/sh is not built. This contains drivers
>>> that are essential to devices support by that configuration, including the
>>> PM runtime code in drivers/sh/pm_runtime.c (which implicitly enables the
>>> bus clocks for all devices).
>>>
>>> If CONFIG_ARCH_SHMOBILE_MULTI then build the drivers/sh directory,
>>> but ensure that bits that may conflict (drivers/sh/clk if the common
>>> clock framework is not enabled) are built.
>>>
>>> The ARCH_SHMOBILE_MULTI was added by efacfce5f8a ("ARM: shmobile:
>>> Introduce ARCH_SHMOBILE_MULTI") but this has only just recently been found
>>> due to changes currently only in Simon Horman's tree. This patch is a
>>> partial revert of bf98c1eac1d4a6b ("ARM: Rename ARCH_SHMOBILE to
>>> ARCH_SHMOBILE_LEGACY") to address the issue of drivers not being built.
>>>
>>> It is also possible the drivers/sh/intc will also need to be built
>>> however the lack of intc is not causing a number of drivers to fail
>>> to properly manage their clocks. This is left as an future patch for
>>> that is perfectly fine. someone who understands that part of the code.
>>
>> Laurent, what are you feelings on this?
>
> If we end up needing an interrupt controller supported by drivers/sh/intc for
> a multiplatform kernel I would rather like to port the driver to
> drivers/irqchip instead of compiling drivers/sh/intc for the platform.
>
> Regarding drivers/sh/pm_runtime.c, compiling it for ARCH_SHMOBILE_MULTI will
> cause multiplatform kernels running on non-Renesas platforms to add a pm clock
> notifier. We need to at least add a runtime check.

Hmm, could we move that to the mstp code or add bindings to the
specific architectures that need it?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
