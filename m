From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Thu, 11 Jun 2009 01:37:05 +0000
Subject: Re: [PATCH] sh: fix clock for sh7785
Message-Id: <4A305FC1.3080300@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4A2F461A.8080506@renesas.com>
In-Reply-To: <4A2F461A.8080506@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Magnus Damm wrote:
> On Wed, Jun 10, 2009 at 2:35 PM, Yoshihiro
> Shimoda<shimoda.yoshihiro@renesas.com> wrote:
>> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
>> ---
>>  Could you apply this patch to linux-2.6.30?
>>  If impossible, this patch is not necessary because clock-sh7785.c will modify
>>  in linux-2.6.31.
> 
> This patch looks like a workaround for the issue solved by this patch:
> 
> http://patchwork.kernel.org/patch/22299/
> 
> Or am I misunderstanding?

Thank you for your comment.

Because the patch was due to be applied linux-2.6.31,
a problem remains linux-2.6.30. However since linux-2.6.30
had already been released, my patch became unnecessary :)

Thanks,
Yoshihiro Shimoda
