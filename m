From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 28 Mar 2011 03:45:11 +0000
Subject: Re: [PATCH] sh: sh-sci: Check initialization for earlyprintk
Message-Id: <4D900447.6070502@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1301279675-16519-1-git-send-email-iwamatsu@nigauri.org>
In-Reply-To: <1301279675-16519-1-git-send-email-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Iwamatsu-san,

2011/03/28 11:34, Nobuhiro Iwamatsu wrote:
> When user do not set earlyprink, initialization is performed in the state
> that setting is not performed. In this case sh-sci does not work.
> This checks the initialization.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Thank you for this patch.
I tested this patch, and confirmed that the sh-sci worked correctly.
When I didn't this patch without earlyprintk on ecovec24 and sh7757lcr,
the sh-sci didn't output any console log.

Thanks,
Yoshihiro Shimoda
