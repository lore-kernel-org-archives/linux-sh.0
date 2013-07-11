From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Date: Thu, 11 Jul 2013 01:21:54 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: Force ARM mode to compile reset vector for secondary CPUs
Message-Id: <51DE08B2.6060309@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1373421397-1786-1-git-send-email-koba@kmckk.co.jp>
 <1373421397-1786-3-git-send-email-koba@kmckk.co.jp>
 <20130710132059.GC13716@verge.net.au>
In-Reply-To: <20130710132059.GC13716@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Thank you, Simon-san.

I will post the backport patch to next LTSI kernel.

(2013/07/10 22:20), Simon Horman wrote:
> On Wed, Jul 10, 2013 at 10:56:36AM +0900, Tetsuyuki Kobayashi wrote:
>> Instructions start from boot vector must be ARM mode.
>> This patch specify ARM mode explicitly and use 'bx' instruction to be
>> able to change to Thumb mode.
>>
>> Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
>> ---
>>   arch/arm/mach-shmobile/headsmp.S |    5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> Thanks, I have queued this up with Magnus's ack in the thumb-fixes
> branch of my renesas tree on kernel.org. It should be
> included in the renesas-next-20130710v2 tag.
>

