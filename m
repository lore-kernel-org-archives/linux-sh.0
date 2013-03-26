From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 26 Mar 2013 14:19:05 +0000
Subject: Re: [PATCH 0/3 v3] ARM: shmobile: add R8A7778 Bock-W board support v3
Message-Id: <CANqRtoTRPN8esU-iiQNtr3f6gZ1gAiXHMHZzXw2cFoBEPNW1VA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87hakhrpmn.wl%kuninori.morimoto.gx@renesas.com>
 <878v5hf4zr.wl%kuninori.morimoto.gx@renesas.com>
 <20130321104127.GH2348@verge.net.au>
In-Reply-To: <20130321104127.GH2348@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon, Morimoto-san,

On Thu, Mar 21, 2013 at 7:41 PM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Mar 21, 2013 at 06:59:20PM +0900, Kuninori Morimoto wrote:
>>
>> Hi Simon, Magnus, Arnd
>>
>> These are v3 patch set of R8A7778 R-Car M1 SoC/board support
>> This SoC/board support have limited DT only.
>> (TMU/SCIF can't use DT at this point)
>>
>> I will work for external IRQ and SMSC support
>> if these are accepted.
>>
>> These patches are based on simon/next branch
>
> Good choice :^)
>
> I have no objections to these changes at this point
> but I would appreciate an ack from Magnus before applying them.

I've looked through this series and they look good to me.

Acked-by: Magnus Damm <damm@opensource.se>
