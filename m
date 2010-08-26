From: Yusuke Goda <yusuke.goda.sx@renesas.com>
Date: Thu, 26 Aug 2010 04:59:25 +0000
Subject: Re: [PATCH 3/4] sh_mmcif: Allow the platform to specify own get_cd
Message-Id: <4C75F4AD.1070804@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1282663622-20564-1-git-send-email-arnd@arndnet.de>
 <1282663622-20564-4-git-send-email-arnd@arndnet.de>
In-Reply-To: <1282663622-20564-4-git-send-email-arnd@arndnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Hannemann <arnd@arndnet.de>
Cc: ian@mnementh.co.uk, sameo@linux.intel.com, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

Hi Arnd

Thanks, your patches!

Arnd Hannemann wrote:
> In some platforms (e.g. AP4EVB) the card detect pin of a slot is not directly
> connected to the sh_mmcif controller, so that polling needs to be used. To
> overcome the overhead induced by querying the controller on each poll cycle,
> card detection can be handled in the platform code more efficiently.
> This patch exposes a get_cd hook for that purpose.
> 
> Signed-off-by: Arnd Hannemann <arnd@arndnet.de>

I confirmed normal operation in the following environment.
 - AP4EVB board
 - CN7 (MMCIF)

Tested-by: Yusuke Goda <yusuke.goda.sx@renesas.com>

