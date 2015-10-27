From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 27 Oct 2015 22:56:53 +0000
Subject: Re: [PATCH] ARM: shmobile: porter: add CAN0 DT support
Message-Id: <56300135.703@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
 <5706086.RKBCVZugI4@wasted.cogentembedded.com>
 <20151027224142.GB21745@verge.net.au>
In-Reply-To: <20151027224142.GB21745@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 10/28/2015 01:41 AM, Simon Horman wrote:

>> Define the Porter board dependent part of the CAN0 device node.
>>
>> This patch is  analogous to the commit 457acc4a6ce8 (ARM: shmobile:
>> henninger: add CAN0 DT support) as there are no differences between the
>> boards in this respect.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> Thanks, I have queued this up for v4.5 after updating the changelog
> as per checkpatch.pl's insight:
>
> ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 457acc4a6ce8 ("ARM: shmobile: henninger: add CAN0 DT support")'
> #8:
> This patch is  analogous to the commit 457acc4a6ce8 (ARM: shmobile:

    Oops, sorry, forgot to update the patch description.

MBR, Sergei

