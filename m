From: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
Date: Tue, 13 Mar 2012 11:08:49 +0000
Subject: Re: [PATCH] sh-sci: fix a race of DMA submit_tx on transfer
Message-Id: <4F5F2AC1.8060305@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4F5DC485.8020607@renesas.com>
In-Reply-To: <4F5DC485.8020607@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Thank you for your reply.

> It looks like sci_start_tx() can be called asynchronously - before the 
> previous request has completed. In such a case we have to actually protect 
> the whole function. 
Perhaps.
Low level debugging shows sci_start_tx() called twice before work_fn_tx(), just before the issue occurs.
I don't know if this frequent calls is an erroneous behavior or not, though.

> ... Please, check whether this slightly simpler patch 
> works for you too. 
Not working. (it crashes)

I applied only
> +	    !s->desc_tx)
(You mean *!*s->desc_tx, don't you? Otherwise no output)

Spin-locks are not needed (and should not be) here, because this function
is called with lock held.

> ... If it does, we can then actually completely remove the 
> cookie_tx member of struct sci_port:
Doing same as my patch with desc_tx instead of cookie_tx, introducing
other special value like desc_tx=1 or so, is OK. Because what is done
by the patch is manual mutex by flag variable, choice of the variable
is not a problem.

The problem seems to be that I don't know how the .start_tx() should
be called. Shall we go to linux-serial ML?

Cheers,
/yoshii
