From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 27 Oct 2015 09:22:08 +0000
Subject: Re: [PATCH/RFT 0/7] HDMI capture on Lager
Message-Id: <CAO3366ykhg7PJAy5CJSyhOts8-i2gOjnU6AEiK3QTwf2D_pvUQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1445263660-6945-1-git-send-email-ulrich.hecht+renesas@gmail.com>
	<5625043D.5010007@cisco.com>
In-Reply-To: <5625043D.5010007@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Verkuil <hansverk@cisco.com>
Cc: SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>, William Towle <william.towle@codethink.co.uk>, Robert Taylor <rob.taylor@codethink.co.uk>, hans.verkuil@cisco.com, ian.molton@codethink.co.uk, linux-media@vger.kernel.org

On Mon, Oct 19, 2015 at 4:54 PM, Hans Verkuil <hansverk@cisco.com> wrote:
> On 10/19/2015 04:07 PM, Ulrich Hecht wrote:
>> This series is supposed to serve as a basis for testing the HDMI input on
>> the Lager board.  It is based on the series by William Towle, dropping the
>> patches that have since been merged, and adding the interrupt to the
>> adv7612
>> DT description.
>>
>> The base of this series, Laurent's "pad config allocator" patch, had been
>> deferred pending a retooling of the media controller framework.  I could
>> not, however, find significant activity in that area (read: the patch
>> still
>> applies)...
> Please cross-post this to the linux-media mailinglist, otherwise it will
> likely be lost.
>
> BTW a lot of work is being done in the media controller framework, but
> nothing has been merged yet. It looks likely to be merged for kernel 4.5.

Could you point me to that work?  I have checked out the master and
media-controller branches of the media tree, but the patch series
still applies (and works) there, so I'm wondering if I'm looking in
the wrong places.  Thank you.

CU
Uli
