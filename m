From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 13 Feb 2014 18:17:53 +0000
Subject: Re: [PATCH 2/5] ARM: shmobile: r8a7790: add dmac0 dmac1 nodes
Message-Id: <52FD0C51.7050803@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1375892397-5822-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375892397-5822-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 12/02/14 19:18, Geert Uytterhoeven wrote:
> On Wed, Feb 12, 2014 at 6:59 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>> +               sysdma1: dmac@e6720000 {
>> +                       compatible = "renesas,dma-r8a7790";
>> +                       clocks = <&mstp2_clks R8A7790_CLK_SYS_DMAC1>;
>> +                       dma-channels = <15>;
>
> 15 channels
>
>> +                       reg = <0 0xe6720020 0 0xffc0>;
>> +                       status = "disabled";
>> +
>> +                       interrupt-parent = <&gic>;
>> +                       interrupts =  <0 220 IRQ_TYPE_LEVEL_HIGH>,
>
> error
>
>> +                                       <0 216 IRQ_TYPE_LEVEL_HIGH>,
>> +                                       <0 217 IRQ_TYPE_LEVEL_HIGH>,
>> +                                       <0 218 IRQ_TYPE_LEVEL_HIGH>,
>> +                                       <0 219 IRQ_TYPE_LEVEL_HIGH>,
>> +                                       <0 308 IRQ_TYPE_LEVEL_HIGH>,
>> +                                       <0 309 IRQ_TYPE_LEVEL_HIGH>,
>> +                                       <0 310 IRQ_TYPE_LEVEL_HIGH>,
>> +                                       <0 311 IRQ_TYPE_LEVEL_HIGH>,
>> +                                       <0 312 IRQ_TYPE_LEVEL_HIGH>,
>> +                                       <0 313 IRQ_TYPE_LEVEL_HIGH>,
>> +                                       <0 314 IRQ_TYPE_LEVEL_HIGH>,
>> +                                       <0 315 IRQ_TYPE_LEVEL_HIGH>,
>> +                                       <0 316 IRQ_TYPE_LEVEL_HIGH>,
>> +                                       <0 317 IRQ_TYPE_LEVEL_HIGH>,
>> +                                       <0 318 IRQ_TYPE_LEVEL_HIGH>;
>
> ch0 - ch14
>
>> +                       interrupt-names = "error",
>> +                                       "ch0", "ch1", "ch2", "ch3",
>> +                                       "ch4", "ch5", "ch6", "ch7",
>> +                                       "ch8", "ch9", "ch10", "ch11",
>> +                                       "ch12", "ch13", "ch14", "ch15";
>
> Oops, ch15 is the 16th entry?

Thanks, will fix it.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
