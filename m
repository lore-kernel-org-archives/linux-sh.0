From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 07 Aug 2009 05:46:34 +0000
Subject: Re: [PATCH] mtd: make onenand/generic.c more generic
Message-Id: <aec7e5c30908062246m2ef5b13dv57dd05bd07d23d67@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090804092046.16025.83910.sendpatchset@rx1.opensource.se>
	<9c9fda240908042124y4f783dfehd575601c0a09550e@mail.gmail.com>
	<aec7e5c30908042141l18b25ba4l66b3cb309f080b21@mail.gmail.com>
	<aec7e5c30908062228g737c1f6cr25f6c67c07d80bd9@mail.gmail.com>
	<20090807053020.GA902@linux-sh.org>
In-Reply-To: <20090807053020.GA902@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Kyungmin Park <kmpark@infradead.org>, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, dwmw2@infradead.org, akpm@linux-foundation.org

On Fri, Aug 7, 2009 at 2:30 PM, Paul Mundt<lethal@linux-sh.org> wrote:
> On Fri, Aug 07, 2009 at 02:28:01PM +0900, Magnus Damm wrote:
>> On Wed, Aug 5, 2009 at 1:41 PM, Magnus Damm<magnus.damm@gmail.com> wrote:
>> >> On Tue, Aug 4, 2009 at 6:20 PM, Magnus Damm<magnus.damm@gmail.com> wrote:
>> >>> From: Magnus Damm <damm@igel.co.jp>
>> >>>
>> >>> This patch removes the ARM dependency from the generic "onenand"
>> >>> platform device driver. This change makes the driver useful for
>> >>> other architectures as well. Needed for the SuperH kfr2r09 board.
>> >
>> Any update on this?
>>
> You have failed at reading your email:
>
> http://lists.infradead.org/pipermail/linux-mtd/2009-August/026805.html
> http://lists.infradead.org/pipermail/linux-mtd/2009-August/026809.html

As usual, sorry about that. I'll solve that soon enough by signing off
with a different address.

/ magnus
