From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 31 Oct 2013 19:36:58 +0000
Subject: Re: Question about r8a7779 ether
Message-Id: <5272BF65.9000509@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvrhq143.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvrhq143.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 10/31/2013 12:30 PM, Simon Horman wrote:

>> You know, we are removing r8a7779_add_xxx_device()
>> from setup-r8a7779.
>> When I cleaned these functions from setup-r8a7779,
>> if my memory was correct, Sergei requested not to clean up
>> r8a7779_add_ether_device(), since he sends patch for marzen.

>> But current marzen still doesn't use it.
>> I'm checking renesas-devel-v3.12-rc7-20131030 tag.
>> According to git log, r8a7779_add_ether_device() was added Apr 2013,
>> and today, Nov 2013.

> Its still October, just :^)

    Yep, even now. :-)

>> Does Marzen need it ?
>> If yes, who has this patch ? or what is current status of it ?

>> No one is using it in this 6 month.
>> (and normal marzen board doesn't have sh_eth implement).
>> Can I remove it anyway ?

>> r8a7779_add_ether_device() was added by this commit

>  From my POV it sounds reasonable to remove it.

    No objections from me this time.

WBR, Sergei

