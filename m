From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Jun 2016 08:04:57 +0000
Subject: Re: [PATCH v2 12/17] sh: Add PCI host bridge driver for SH7751
Message-Id: <CAMuHMdXvWxCzVeMnLSPdHd-Xod_EqB_iEjbebpwqt4MgcqjCcA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1465714475-24111-1-git-send-email-ysato@users.sourceforge.jp> <1465714475-24111-13-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1465714475-24111-13-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Sun, Jun 12, 2016 at 8:54 AM, Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> This is alternative SH7751 PCI driver.

an alternative

> Existing driver (arch/sh/drivers/pci/pci-sh7751) use SH specific interface.

uses

> But this driver using common PCI interface. It more mordan and generic.

uses ... it is more modern ...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
