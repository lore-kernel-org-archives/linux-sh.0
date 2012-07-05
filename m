From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 05 Jul 2012 00:53:58 +0000
Subject: Re: [RFC][PATCH] ARM: shmobile: kzm9g: add r8a66597_udc support
Message-Id: <87fw97qb8c.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2921A.2080803@kmckk.co.jp>
In-Reply-To: <4FF2921A.2080803@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Kobayashi-san

> > I'm not sure the maintainer's opinion,
> > but if this patch is only for the "test", then #ifdef xx_TEST_xx is better name.
> >
> > OTOH, if you add "choice" in Kconfig to select UDC/HCD (not for test),
> > it is better for users.
> >
> Now in my mind, I will choose the latter. KZM-A9-GT is an *evaluation* 
> board, so someone want to evaluate R8A66597_UDC.

cool !

> >> +#ifdef USE_R8A66597_UDC
> >> +	/*
> >> +	 * Do not enable usb_host_device because r8a66597_udc and r8a66597_hcd
> >> +	 * can not use at the same time.
> >> +	 * Also, do not enable usbhs_device for simplify.
> >> +	 */
> >> +	&usb1_gadget_device,
> >> +#else
> >>   	&usb_host_device,
> >>   	&usbhs_device,
> >> +#endif
> >
> > Why is usbhs_device disabled for simplify ?
> > what's happen if it was enabled ?

> If the board has only one USB gadget, it is simple and almost
> board has only one USB gadget.
> But I don't understand yet how it works if the board has 2 or more
> USB devices. Is it possible one for mass storage and the other for
> ethernet over USB, or so?

I think so on latest kernel. (old kernel didn't support it)
I forgot detail of it, but 2usb-gadget worked correctly on other board (= mackerel ?)
 > insmod g_mass_strage file=xxx
 > insmod g_ether
If it doesn't work correctly, driver seems broken

# Current kzm9g board is using r8a66597_hcd/udc driver, since renesas_usbhs still doesn't support
# "external" chip yet.
# But in the future, it should be switched to use renesas_usbhs instead of r8a66597_xxx.

I don't care if you disabled renesas_usbhs or not.
(I don't know maintainer's opinion)
But when you use that style, please care compile warning.
I got this

/opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/arch/arm/mach-shmobile/board-kzm9g.c:123:31: warning: 'usb_host_device' defined but not used [-Wunused-variable]
/opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/arch/arm/mach-shmobile/board-kzm9g.c:298:31: warning: 'usbhs_device' defined but not used [-Wunused-variable]


Best regards
---
Kuninori Morimoto
