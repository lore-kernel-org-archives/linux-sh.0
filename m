From: Michal Nazarewicz <mina86@mina86.com>
Date: Tue, 28 Oct 2014 16:57:45 +0000
Subject: Re: CMA: test_pages_isolated failures in alloc_contig_range
Message-Id: <xa1tfve8ku7q.fsf@mina86.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2457604.k03RC2Mv4q@avalon> <xa1tsii8l683.fsf@mina86.com> <544F9EAA.5010404@hurleysoftware.com>
In-Reply-To: <544F9EAA.5010404@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Peter Hurley <peter@hurleysoftware.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>

> On 10/28/2014 08:38 AM, Michal Nazarewicz wrote:
>> Like Laura wrote, the message is not (should not be) a problem in
>> itself:
>
> [...]
>
>> So as you can see cma_alloc will try another part of the cma region if
>> test_pages_isolated fails.
>> 
>> Obviously, if CMA region is fragmented or there's enough space for only
>> one allocation of required size isolation failures will cause allocation
>> failures, so it's best to avoid them, but they are not always avoidable.
>> 
>> To debug you would probably want to add more debug information about the
>> page (i.e. data from struct page) that failed isolation after the
>> pr_warn in alloc_contig_range.

On Tue, Oct 28 2014, Peter Hurley <peter@hurleysoftware.com> wrote:
> If the message does not indicate an actual problem, then its printk level is
> too high. These messages have been reported when using 3.16+ distro kernels.

I think it could be argued both ways.  The condition is not an error,
since in many cases cma_alloc will be able to continue, but it *is* an
undesired state.  As such it's not an error but feels to me a bit more
then just information, hence a warning.  I don't care either way, though.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Michał “mina86” Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
