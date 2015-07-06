From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 06 Jul 2015 13:22:58 +0000
Subject: Re: Build regressions/improvements in v4.2-rc1
Message-Id: <20150706132258.GA3102@roeck-us.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1436174858-10254-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdVm+_KyHLx=--0tm5iTgJ4nfMkhxCkoUqhqpbQL6gO82Q@mail.gmail.com>
In-Reply-To: <CAMuHMdVm+_KyHLx=--0tm5iTgJ4nfMkhxCkoUqhqpbQL6gO82Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Mon, Jul 06, 2015 at 11:35:25AM +0200, Geert Uytterhoeven wrote:
> 
> >   + /home/kisskb/slave/src/drivers/net/ethernet/via/via-rhine.c: error: implicit declaration of function 'pci_iomap' [-Werror=implicit-function-declaration]:  => 1098:2
> >   + /home/kisskb/slave/src/drivers/net/ethernet/via/via-rhine.c: error: implicit declaration of function 'pci_iounmap' [-Werror=implicit-function-declaration]:  => 1119:2
> 
> sh-allmodconfig
> sh-allyesconfig
> 
> sh doesn't use <asm-generic/pci_iomap.h>, and doesn't provide dummies of
> pci_io{,un}map().
> 

Another side effect of b7d3282a245f4 ("net: via/Kconfig: replace USE_OF with
OF_???").

> >   + error: No rule to make target drivers/scsi/aic7xxx/aicasm/*.[chyl]:  => N/A
> 
This one is historic and keeps popping up.

Guenter
