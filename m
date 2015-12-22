From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Tue, 22 Dec 2015 16:20:21 +0000
Subject: Re: [PATCH 1/2] drivers/pci: make host/pcie-rcar.c explicitly non-modular
Message-Id: <56797845.1070506@windriver.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450745949-23882-1-git-send-email-paul.gortmaker@windriver.com>	<1450745949-23882-2-git-send-email-paul.gortmaker@windriver.com> <CAMuHMdX-ek6eG9kXt1R4vVHUqe2ggpMCxQ33H512VQ66hRKrAg@mail.gmail.com>
In-Reply-To: <CAMuHMdX-ek6eG9kXt1R4vVHUqe2ggpMCxQ33H512VQ66hRKrAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci <linux-pci@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Phil Edworthy <phil.edworthy@renesas.com>

On 2015-12-22 03:30 AM, Geert Uytterhoeven wrote:
> Hi Paul,
> 
> On Tue, Dec 22, 2015 at 1:59 AM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
>> We also delete the MODULE_LICENSE tag etc. since all that information
>> was (or is now) contained at the top of the file in the comments.
> 
> The MODULE_* tags are easier to parse by automated tools.
> Do we want to make the work of e.g. the SPDX people harder?

As JoeP pointed out, the AUTHOR tags are routinely out of date
and not used by get_maintainer.pl by default, and I've found a
lot of LICENCE tags that say GPL while the text at the top says
GPLv2.  On top of that, they are not present all the time since
proper non-modular drivers don't have them.  So, no I have no
problems whatsoever in removing them from non-modular code.

If you want to make the case for tags that are module/non-module
agnostic, and you think there is genuine value in it and you can
get buy in on that, then feel free.

Paul.
--

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
