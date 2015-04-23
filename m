From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Date: Thu, 23 Apr 2015 08:41:43 +0000
Subject: Re: [PATCH] TESTCASE: of: OOPS when disabling node via OF_DYNAMIC
Message-Id: <792609BD-3B81-43EA-95EB-511857B54AF7@konsulko.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1427814771-30335-1-git-send-email-wsa@the-dreams.de> <AEA6F5CA-D520-4F34-BE6B-EF2839501089@konsulko.com> <20150414132709.GA1375@katana> <83B5C458-8D49-4EF6-9F4A-6C0E2579AB9F@konsulko.com> <20150423083322.GA15071@katana>
In-Reply-To: <20150423083322.GA15071@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org

Hi Wolfram,

> On Apr 23, 2015, at 11:33 , Wolfram Sang <wsa@the-dreams.de> wrote:
> 
> 
>> Sorry for the non-prompt reply; but just for kicks, can you try the attached patch?
>> 
>> I have a hunch this might be the problem.
> 
> Yeah, this even makes my more complex driver work \o/ I will post it
> once -rc1 is out. Thanks a lot for your help, much appreciated!
> 

Good!

This patch has been posted before but up to now, no-one had a test case that triggered
the bug, so gregh was reluctant to pick it up.

Let’s gang up on him :)

Regards

— Pantelis

