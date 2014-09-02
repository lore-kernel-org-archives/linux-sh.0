From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 02 Sep 2014 18:10:01 +0000
Subject: Re: [PATCH v2] Revert "i2c: rcar: remove spinlock"
Message-Id: <540607F9.4060802@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1642788.pEhrsPDp4u@wasted.cogentembedded.com> <20140824064520.GA2578@katana> <53F9CCE7.3010006@cogentembedded.com> <20140825034009.GA2795@katana> <53FB1F90.6080704@cogentembedded.com> <20140825143316.GA1285@katana> <5405FAD3.90403@cogentembedded.com> <20140902171835.GA10355@katana> <5405FE27.4050909@cogentembedded.com> <20140902174548.GB10355@katana>
In-Reply-To: <20140902174548.GB10355@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org

On 09/02/2014 09:45 PM, Wolfram Sang wrote:

>>> I don't see why. If we have two patches, the state inbetween them is
>>> broken.

>>     Even so, it has always been broken, we don't make it more broken by
>> reverting your change.

> Yes. Still, if I send something to *stable*, less broken is not an
> option for me, if I know there is a fix possible. And we are at -rc3
> now, so there is still time for that.

    Not as much time for me since I'm leaving for vacations at the start of 
the next week. And I have other areas to care about before that.

>>> And we don't have two patches yet, just the revert. So, the

>>     I'm going to consider the spinlock issue ASAP, after I check whether the
>> I2C clock frequency really has any influence on the unexpected read NACK
>> issue I've been chasing for several days.

> Good luck with that! Such bugs are truly annoying :(

   Sigh, that whole issue looks like hardware bug to me (the vendor kernel 
reportedly doesn't have it though)... overall, this hardware seems excessively 
buggy, despite I2C protocol is not really rocket science.

>>     Your patch removing the spinlock went into 3.16 only but we'd have to
>> backport the assumed single patch to the -stable kernels older than that.
>> This means that I'd have to provide the "delta" patch (i.e. the separate
>> patch that I'd like to provide now atop of the revert) for these kernels
>> instead since the original single patch wouldn't apply anyway.

> With all my changes in 3.16, I wonder if the patch with your addition to
> the revert will apply anyhow.

    Resolution of the context issues is different from the patch principally 
not applying as the changes it has are already there.

> But, okay, you send two patches, and I
> will decide how I apply them and deal with delta-patches. Okay?

    So you mean that I need to repost the revert? I'm OK with that since the 
context has most probably changed with my recent patch...

> All the best,

>     Wolfram

WBR, Sergei

