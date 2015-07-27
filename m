From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 27 Jul 2015 16:30:39 +0000
Subject: Re: [PATCH v2 0/3] bockw SD pull-ups
Message-Id: <CAO3366xJ0_=ehAsDM8JfG9+VE6p3=OQhRbgeG9kWtz0kRSBJWw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1437751317-12235-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1437751317-12235-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 27, 2015 at 3:09 AM, Simon Horman <horms@verge.net.au> wrote:
> Hi Ulrich,
>
> On Fri, Jul 24, 2015 at 05:21:54PM +0200, Ulrich Hecht wrote:
>> Hi!
>>
>> This series implements pull-up configuration in the r8a7778 PFC driver
>> and sets the SD0_WP and SD0_CD pull-ups on the Bock-W board correctly,
>> replacing the hack that is used in the legacy platforms.
>>
>> This revision uses bitfields for the pull-up table, reducing its size to 310
>> bytes, and demotes undefined pull-ups from a bug to a warning.
>
> I am wondering if these patches create any forwards/backwards compatibility
> issues if the kernel and DT are not upgraded simultaneously.

I don't think so.  The driver support without the DT changes will not
do anything.  DT changes without driver support will yield an error
message, but other than that it should not have any detrimental
effect.

CU
Uli
