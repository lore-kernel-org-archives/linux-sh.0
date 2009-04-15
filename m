From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 15 Apr 2009 12:12:15 +0000
Subject: Re: [PATCH 3/6] Add USB support for SH7724
Message-Id: <20090415121214.GC16961@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uzlej1ubl.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzlej1ubl.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 15, 2009 at 09:16:10PM +0900, Magnus Damm wrote:
> On Wed, Apr 15, 2009 at 8:49 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > On Wed, Apr 15, 2009 at 11:42 AM, Kuninori Morimoto
> > <morimoto.kuninori@renesas.com> wrote:
> >> +++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
> 
> >> +#define UPONCR0 ? ? ? ? ? ? ? ?0xa40501d4
> >> +#define UPONCR1 ? ? ? ? ? ? ? ?0xa4050192
> >> +#define USBPOWERON ? ? 0x0600
> >> +static void __init sh7724_usb_setup(void)
> >> +{
> >> + ? ? ? /*
> >> + ? ? ? ?* USB initial settings
> >> + ? ? ? ?*
> >> + ? ? ? ?* The following settings are necessary
> >> + ? ? ? ?* for using the USB modules.
> >> + ? ? ? ?*
> >> + ? ? ? ?* see "USB Inital Settings" for detail
> >> + ? ? ? ?*/
> >> + ? ? ? __raw_writew(USBPOWERON , UPONCR0);
> >> + ? ? ? __raw_writew(USBPOWERON , UPONCR1);
> >> +}
> >
> > Hm... In the future we want to control the above dynamically for
> > better power savings. I guess it's ok as-is for now.
> 
> Looking a bit in r8a66597.h, I wonder if USBPOWERON is similar to
> VBOUT that is present in DVSTCR on external devices?
> 
Also note that the same issue exists on SH7786, so if this is fixed a bit
more intelligently, the same thing should carry over there.
