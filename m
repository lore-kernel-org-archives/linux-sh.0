From: NISHIMOTO Hiroki <nishimoto.hiroki@renesas.com>
Date: Tue, 23 Feb 2010 00:58:11 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: pfc-sh7377: modify KEYIN settings
Message-Id: <4B832823.6040902@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <ur5ohpsh7.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <ur5ohpsh7.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Sorry, the issue is my test environment.
This patch remedy a keysc setting.
Please apply this patch.


Paul Mundt wrote:
> On Mon, Feb 22, 2010 at 04:32:28PM +0900, NISHIMOTO Hiroki wrote:
>   
>> I tested this patch and found that it made the keysc behavior worse.
>> Please stop applying the patch.
>>
>> I will investigate the cause of the issue and send a patch latar.
>>
>>     
> When this patch is resubmitted it should also have a sensible changelog,
> since it's obvious that this is not just a simple mechanical change.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   


