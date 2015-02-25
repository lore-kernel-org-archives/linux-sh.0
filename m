From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 25 Feb 2015 23:28:36 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a73a4: Remove legacy code
Message-Id: <54EE5AA4.30004@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418771008-5676-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418771008-5676-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 02/26/2015 02:23 AM, Simon Horman wrote:

>>>> I saw it, too. But as renesas-devel-20150224-4.0-rc1 predates the email
>>>> from Simon, I assumed he just hasn't pushed out that version yet.

>>>     BTW, does this tag work for anybody? I got the kernel hang with the blank
>>> console after the kernel decompression on the SILK board. After I enabled
>>> CONFIG_DEBUG_LL and early printk(), I saw that the PFC driver fails to load,
>>> all drivers dependent on the PFC driver failing the probes, and then the
>>> early console was disabled before I could see any crash report... I will
>>> provide the kernel log a bit later if anybody is interested...

>> Sure, my tree is based on that, and works on r8a73a4/ape6evm,
>> r8a7740/armadillo, r8a7791/koelsch, and sh73a0/kzm9g.

> FWIW I also tested the above tag on a range of boards.

    Sorry about false alarm, it was all due to implementing Laurent's 
suggestions in the PFC driver. :-) Looks like we both haven't properly tested 
them... :-/

WBR, Sergei

