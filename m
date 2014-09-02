From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 02 Sep 2014 17:13:55 +0000
Subject: Re: [PATCH v2] Revert "i2c: rcar: remove spinlock"
Message-Id: <5405FAD3.90403@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1642788.pEhrsPDp4u@wasted.cogentembedded.com> <20140824064520.GA2578@katana> <53F9CCE7.3010006@cogentembedded.com> <20140825034009.GA2795@katana> <53FB1F90.6080704@cogentembedded.com> <20140825143316.GA1285@katana>
In-Reply-To: <20140825143316.GA1285@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello.

On 08/25/2014 06:33 PM, Wolfram Sang wrote:

>>     Ah, I misunderstood you. However, I don't quite understand why you want
>> to combine revert and the mentioned updates...

> As I understood from your previous mail, a plain revert is less broken
> but still broken. Applying a correct fix is my preferred way.

    Actually, from the -stable kernel perspective, a single patch would 
complicate backporting. So could you please reconsider?

WBR, Sergei

