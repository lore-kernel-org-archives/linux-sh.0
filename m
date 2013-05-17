From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 17 May 2013 16:49:43 +0000
Subject: Re: [PATCH] <linux/of_platform.h>: fix compilation warnings with DT disabled
Message-Id: <CACxGe6vWH1mvnd6nEO2tpGGDHOZROdCw4cYwk7x4GVEDxoNayA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201302190258.25726.sergei.shtylyov@cogentembedded.com>
 <20130301070925.GA24369@verge.net.au> <5130B12F.20409@gmail.com>
 <5130B1A7.9060001@gmail.com> <5130B34F.2090700@cogentembedded.com>
 <5130B506.5020908@gmail.com> <5195486F.1040603@cogentembedded.com> <CAL_JsqLkshrBDDKtdf+KYufg=83Yn7zAFmHKUpoA848JzbQKmw@mail.gmail.com>
In-Reply-To: <CAL_JsqLkshrBDDKtdf+KYufg=83Yn7zAFmHKUpoA848JzbQKmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robherring2@gmail.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, vladimir.barinov@cogentembedded.com

On Thu, May 16, 2013 at 11:44 PM, Rob Herring <robherring2@gmail.com> wrote:
>>     I hoped to see this fix in 3.10-rc1. Is there any hope to see it in
>> 3.10-rc's?
>> The code it fixes the warnings in is already in Linus tree.
>
> So I had this queued up, but Grant did not send DT update to Linus for
> 3.10. The main thing we had was the preprocessor support and that went
> thru arm-soc tree. I plan to send this and other fixes to Linus for
> 3.10.

I got gun shy from the gpio stuff and fixated on better testing of my
tree. Everything in my tree is bug fixes so I'll be sending the pull
request today

g.
