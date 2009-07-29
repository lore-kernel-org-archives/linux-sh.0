From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 29 Jul 2009 14:11:16 +0000
Subject: Re: [BUG] Error in copy_process, when enable CONFIG_PROVE_LOCKING.
Message-Id: <20090729141116.GA24109@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <29ab51dc0905112140v3187b462qcc8a9e5385de8ef6@mail.gmail.com>
In-Reply-To: <29ab51dc0905112140v3187b462qcc8a9e5385de8ef6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 12, 2009 at 01:40:35PM +0900, Nobuhiro Iwamatsu wrote:
> Error in copy_process, when enable CONFIG_PROVE_LOCKING.
> This error has p->hardirqs_enabled in kernel.fork.c
> 
>  987 #ifdef CONFIG_PROVE_LOCKING
>  988     DEBUG_LOCKS_WARN_ON(!p->hardirqs_enabled);
>  989     DEBUG_LOCKS_WARN_ON(!p->softirqs_enabled);
>  990 #endif
>  991     retval = -EAGAIN;
> 
> The error message is as follows.
> I am debuging this. Please teach if you know the revision method of
> this problem.
> 
This should be fixed now in current git. Can you give it a try?
