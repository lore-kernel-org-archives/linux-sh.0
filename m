From: "Yusuke.Goda" <goda.yusuke@renesas.com>
Date: Thu, 05 Jun 2008 03:00:19 +0000
Subject: Re: smc911x: Add AP325RXA board support
Message-Id: <484756C3.4010900@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4846744B.4000407@renesas.com>
 <aec7e5c30806041855j604311b8xad79d9050897d0f1@mail.gmail.com>
In-Reply-To: <aec7e5c30806041855j604311b8xad79d9050897d0f1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

Hi Magnus-san

Magnus Damm wrote:
> Hi Goda-san,
> 
> On Wed, Jun 4, 2008 at 7:54 PM, Yusuke.Goda <goda.yusuke@renesas.com> wrote:
>> This patch adds AP325RXA board support to scc911x driver.
> 
> I posted a few patches recently (smc911x: Request bus width using
> platform data) that are conflicting with your patch. Hopefully my
> patches will be included in 2.6.27, and at that point we can modify
> the ap32x board code to add board specific configuration to the
> smc911x platform data.

I'm sorry I did not watch your patch.
With your patch, my patch was not necessary.

Thanks,
Goda

