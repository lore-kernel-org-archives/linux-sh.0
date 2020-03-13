From: afzal mohammed <afzal.mohd.ma@gmail.com>
Date: Fri, 13 Mar 2020 12:54:40 +0000
Subject: Re: [PATCH v3] sh: replace setup_irq() by request_irq()
Message-Id: <20200313124240.GB7225@afzalpc>
List-Id: <linux-sh.vger.kernel.org>
References: <20200304005120.5403-1-afzal.mohd.ma@gmail.com>
In-Reply-To: <20200304005120.5403-1-afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Yoshinori Sato,

On Wed, Mar 04, 2020 at 06:21:19AM +0530, afzal mohammed wrote:
> request_irq() is preferred over setup_irq(). Invocations of setup_irq()
> occur after memory allocators are ready.
> 
> Per tglx[1], setup_irq() existed in olden days when allocators were not
> ready by the time early interrupts were initialized.
> 
> Hence replace setup_irq() by request_irq().
> 
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
> 
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
> ---
> Hi sh maintainers,
> 
> if okay w/ this change, please consider taking it thr' your tree, else please
> let me know.

Seems you handle pull requests for sh, if this patch is okay, please
consider it for inclusion in your tree.

Regards
afzal
