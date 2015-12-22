From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Dec 2015 08:30:25 +0000
Subject: Re: [PATCH 1/2] drivers/pci: make host/pcie-rcar.c explicitly non-modular
Message-Id: <CAMuHMdX-ek6eG9kXt1R4vVHUqe2ggpMCxQ33H512VQ66hRKrAg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450745949-23882-1-git-send-email-paul.gortmaker@windriver.com>
	<1450745949-23882-2-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1450745949-23882-2-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci <linux-pci@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Phil Edworthy <phil.edworthy@renesas.com>

Hi Paul,

On Tue, Dec 22, 2015 at 1:59 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> We also delete the MODULE_LICENSE tag etc. since all that information
> was (or is now) contained at the top of the file in the comments.

The MODULE_* tags are easier to parse by automated tools.
Do we want to make the work of e.g. the SPDX people harder?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
