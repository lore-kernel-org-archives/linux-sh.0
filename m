From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 03 Dec 2019 18:02:19 +0000
Subject: Re: [PATCH 5/7] sh: pci: Modernize printing of kernel messages
Message-Id: <CAMuHMdUpDcmu=z35d8HDstrqE1+Ef-ZLUGo2dx_5wUkRNPmG4g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20191203162645.19950-1-geert+renesas@glider.be> <20191203162645.19950-6-geert+renesas@glider.be>
In-Reply-To: <20191203162645.19950-6-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>

On Tue, Dec 3, 2019 at 5:26 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>   - Convert from printk() to pr_*(),
>   - Add missing continuations,
>   - Join broken messages.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/sh/drivers/pci/common.c
> +++ b/arch/sh/drivers/pci/common.c
> @@ -143,7 +143,7 @@ unsigned int pcibios_handle_status_errors(unsigned long addr,
>                 printk(KERN_DEBUG "PCI: parity error detected: ");

Forgot to mention: I did not replace "printk(KERN_DEBUG" by "pr_debug",
as this changes behavior (pr_debug() is a dummy if DEBUG is not defined).

>                 pcibios_report_status(PCI_STATUS_PARITY |
>                                       PCI_STATUS_DETECTED_PARITY, 1);
> -               printk("\n");
> +               pr_cont("\n");
>
>                 cmd |= PCI_STATUS_PARITY | PCI_STATUS_DETECTED_PARITY;
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
