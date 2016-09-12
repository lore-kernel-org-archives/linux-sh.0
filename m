From: Bui Duc Phuc <bd-phuc@jinso.co.jp>
Date: Mon, 12 Sep 2016 15:12:08 +0000
Subject: Re: [PATCH 1/8] devicetree: binding: R-car Gen3 CMT0 and CMT1 bindings
Message-Id: <7916c4bd-94a1-0d87-e2dc-2fd852976cfc@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1473421394-9745-1-git-send-email-bd-phuc@jinso.co.jp>
 <1473421394-9745-2-git-send-email-bd-phuc@jinso.co.jp>
 <CAMuHMdVAuyWUid6GEJXNoyw4bH3h=QWmo7eMLyiCayc5UQaoFA@mail.gmail.com>
In-Reply-To: <CAMuHMdVAuyWUid6GEJXNoyw4bH3h=QWmo7eMLyiCayc5UQaoFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Dear Geert,

> I think the plan was to get rid of the renesas,cmt-48-* bindings, as they do
> not allow to differentiate between CMT0 and CMT1, which have different feature
> sets.
>
> Cfr. Magnus' series "clocksource: sh_cmt: DT binding rework V4"
> (https://lkml.org/lkml/2016/3/14/433).
>
> Magnus: What's the status of your series?
Thank for your comments. I will update in V2.
I am still waiting for Magnus's comments, but from my point of 
view,Magnus's patches seem
support 32 bit counter only, they are not suitable for 48bit counter.
According to hardware manual, there has to be registers ( CMCSRH, 
CMCNTH,CMCORH) set for 48 bit counter,
but I do not see the registers ( CMCSRH, CMCNTH,CMCORH) in Magnus's patches.


-- 
Regards,

Bui Duc Phuc

