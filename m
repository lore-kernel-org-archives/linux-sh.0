From: Takashi Yoshii <yoshii.takashi@renesas.com>
Date: Fri, 05 Dec 2008 09:32:17 +0000
Subject: Re: [PATCH] Add plain udivsi3 (not _i4*) for gcc-4.1 and lower.
Message-Id: <4938F521.2000401@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49389A5D.5040107@renesas.com>
In-Reply-To: <49389A5D.5040107@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Nobuhiro Iwamatsu wrote:
> Please use -C option.
Wow! Amazing!    .... but, result was not super good.

What I got was a record doing
 mv udivsi3-Os.S udivsi3_i4i-Os.S; edit udivsi3_i4i-Os.S
 cp udivsi3.S udivsi3_i4i.S; edit udivsi3_i4i.S
 edit udivsi3.S
while I did
 mv udivsi3-Os.S udivsi3_i4i-Os.S; edit udivsi3_i4i-Os.S
 mv udivsi3.S udivsi3_i4i.S; edit udivsi3_i4i.S
 create udivsi3.S
.

I known I can record them correctly in two commits, mvmv and create.
I wonder if I should send two patch or no...
Or, is there a way to do in one shot?

Cheers,
/yoshii
