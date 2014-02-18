From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 18 Feb 2014 02:35:25 +0000
Subject: Re: [PATCH] ARM: shmobile: Remove EMEV2 header file
Message-Id: <CANqRtoSmphPAaxOFjAQcZ8RDigJpjYG3yCFMr5C_cw6JCHghkw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140217073508.11156.21720.sendpatchset@w520>
 <20140218000926.GB4776@verge.net.au>
 <20140218023103.GA17063@verge.net.au>
In-Reply-To: <20140218023103.GA17063@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Feb 18, 2014 at 11:31 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Feb 18, 2014 at 09:09:29AM +0900, Simon Horman wrote:
>> On Mon, Feb 17, 2014 at 04:35:08PM +0900, Magnus Damm wrote:
>> > From: Magnus Damm <damm@opensource.se>
>> >
>> > There is no C board code left for the EMEV2 SoC, so
>> > get rid of the emev2.h include file to save some lines.
>> > While at it make functions static.
>> >
>> > Signed-off-by: Magnus Damm <damm@opensource.se>
>>
>> Thanks, I have queued this up.
>
> I have changed my mind and decided to defer this patch
> to avoid a tedious dependency of an SoC patch on a board patch.

That's fine. We can handle further cleanup later. Thanks for your help!

/ magnus
