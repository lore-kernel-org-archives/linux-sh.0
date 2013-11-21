From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 21 Nov 2013 16:22:40 +0000
Subject: Re: [PATCH 5/6] ARM: shmobile: r8a7790: tidyup clock table order
Message-Id: <528E3350.2090200@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8738msep7z.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738msep7z.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 21-11-2013 5:35, Kuninori Morimoto wrote:

>>> In this context I think the comment makes sense.

>>      I disagree because the clocks declared via CLKDEV_ICK_ID() are by nature
>> the same MSTP clocks as the others. This patch looks dangerously close to the
>> needless churn IMHO.

>  From MSTP grouping point of view, you are correct.
>  From PM-Runtime/Clock API point of view, this patch is sane.

    Please explain what it adds from this PoV. And if this patch is going to 
be accepted, I at least would like the dubious "ICK" comment to be removed.

WBR, Sergei

