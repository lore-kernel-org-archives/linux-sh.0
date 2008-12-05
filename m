From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 05 Dec 2008 11:41:20 +0000
Subject: Re: [PATCH] Add plain udivsi3 (not _i4*) for gcc-4.1 and lower.
Message-Id: <20081205114119.GC14492@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49389A5D.5040107@renesas.com>
In-Reply-To: <49389A5D.5040107@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 05, 2008 at 06:32:17PM +0900, Takashi Yoshii wrote:
> Nobuhiro Iwamatsu wrote:
> > Please use -C option.
> Wow! Amazing!    .... but, result was not super good.
> 
> What I got was a record doing
>  mv udivsi3-Os.S udivsi3_i4i-Os.S; edit udivsi3_i4i-Os.S
>  cp udivsi3.S udivsi3_i4i.S; edit udivsi3_i4i.S
>  edit udivsi3.S
> while I did
>  mv udivsi3-Os.S udivsi3_i4i-Os.S; edit udivsi3_i4i-Os.S
>  mv udivsi3.S udivsi3_i4i.S; edit udivsi3_i4i.S
>  create udivsi3.S
> .
> 
> I known I can record them correctly in two commits, mvmv and create.
> I wonder if I should send two patch or no...
> Or, is there a way to do in one shot?
> 
It is a bit difficult to see what precisely you changed given that the
changes are lost in the rename. If you do a rename first and then a
follow-up patch with your actual changes, then it is easier to see what
actually happened. Given that these are just from gcc directly though,
the changes aren't likely to be terribly interesting, so simply fixing
things up in a single change seems reasonable.
