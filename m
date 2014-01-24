From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 24 Jan 2014 11:37:30 +0000
Subject: Re: [PATCH V2 2/3] ARM: shmobile: r8a7790: Add PCI USB host clock support
Message-Id: <52E2507A.3040202@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1389982854-20680-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1389982854-20680-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 24/01/14 04:47, Magnus Damm wrote:
> On Sat, Jan 18, 2014 at 3:20 AM, Valentine Barshak
> <valentine.barshak@cogentembedded.com> wrote:
>> This adds internal PCI USB host clock support.
>>
>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>> ---
>>   arch/arm/mach-shmobile/clock-r8a7790.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> Changes in V2:
>> * capitalized ARM in the subject;
>> * rebased on top the latest devel tag.
>
> This patch for PCI USB clock support seems fine to me.
>
> Acked-by: Magnus Damm <damm@opensource.se>
>
> It is common practice that maintainers reject code to encourage people
> to do further development. I don't think that will help us in this
> particular case, so I think it is best to merge this as-is but also
> request you to spend your future time on DT development.
>
> So please work on DT reference support together with CCF for PCI USB.

I've already posted a series for getting this device treeed.

As a note, does channel 0 work for you? we are getting a lot of
failures with the OHCI controller failing to start with what looks
like a bus-master failure.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
