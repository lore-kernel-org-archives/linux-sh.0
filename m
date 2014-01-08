From: Simon Horman <horms@verge.net.au>
Date: Wed, 08 Jan 2014 00:48:35 +0000
Subject: Re: [PATCH 00/04 v2] ARM: shmobile: r7s72100 and Genmai GPIO / PINCTRL V2
Message-Id: <20140108004832.GJ5136@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20131217050232.727.9552.sendpatchset@w520>
In-Reply-To: <20131217050232.727.9552.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Dec 17, 2013 at 02:02:32PM +0900, Magnus Damm wrote:
> ARM: shmobile: r7s72100 and Genmai GPIO / PINCTRL V2
> 
> [PATCH 01/04] ARM: shmobile: r7s72100 GPIO and PINCTRL device nodes
> [PATCH 02/04] ARM: shmobile: Genmai SCIF2 PINCTRL configuration
> [PATCH 03/04] ARM: shmobile: Genmai LED1 and LED2 support
> [PATCH 04/04 v2] ARM: shmobile: Genmai I2C-over-GPIO support
> 
> Add various device nodes to the r7s72100 SoC and the Genmai board,
> nothing special just basic support for LEDs and I2C-over-GPIO.

If the series is v2 then it would help me greatly if you included
v2 in the subject all all patches. The reason is that it helps to
group the patches visually in patchwork where cover emails and threading
do not exist.

You can make it clear that there were no changes by adding something
like the following to the changelog. But I generally assume there
were no changes in the absence of information to the contrary in the
changelog.

---
v2
* No change
