From: Simon Horman <horms@verge.net.au>
Date: Wed, 18 Feb 2015 21:20:03 +0000
Subject: Re: [PATCH 0/2] ARM: shmobile: emev2 dts: Add pinmux support
Message-Id: <20150218212002.GB12754@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1424179915-17417-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1424179915-17417-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Feb 17, 2015 at 02:31:53PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> Here are the two remaining patches from Niklas Söderlund to add
> pinmux support for EMMA Mobile EV2. The patches for the actual pinctrl
> driver have already landed in Linus' tree.
> 
> Thanks for applying!

Thanks, done.

> Niklas Söderlund (2):
>   ARM: shmobile: emev2 dtsi: Add PFC information
>   ARM: shmobile: emev2-kzm9d dts: Add PFC information for uart1
> 
>  arch/arm/boot/dts/emev2-kzm9d.dts | 13 +++++++++++++
>  arch/arm/boot/dts/emev2.dtsi      | 10 ++++++++++
>  2 files changed, 23 insertions(+)
