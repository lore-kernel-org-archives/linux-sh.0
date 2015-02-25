From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 25 Feb 2015 23:06:54 +0000
Subject: Re: [PATCH v3] sh-pfc: add R8A7794 PFC support
Message-Id: <54EE558E.2020507@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2084538.pWCX8EzoLe@wasted.cogentembedded.com> <54EE2AA8.9000604@cogentembedded.com>
In-Reply-To: <54EE2AA8.9000604@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linus.walleij@linaro.org, linux-sh@vger.kernel.org, laurent.pinchart@ideasonboard.com, linux-gpio@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org

On 02/25/2015 11:03 PM, Sergei Shtylyov wrote:

>> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

>> Add PFC support for  the  R8A7794 SoC  including pin groups for some on-chip
>> devices such as ETH, I2C, INTC, MSIOF, QSPI, [H]SCIF...

>> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>> [Sergei: squashed together several patches, fixed the MLB_CLK typo, added
>> IRQ4..
>> IRQ9 pin groups,  fixed IRQn comments, added ETH B pin group names, removed
>> stray new line and fixed typos in the  comments in the pinmux_config_regs[]
>> initializer, removed the platform device ID, took into account limited
>> number of
>> signals in the GPIO1/5/6 controllers, added reasonable and removed unreasonable
>> copyrights, modified the bindings document, renamed, added changelog.]
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
>> ---
>> Changes in version 3:
>> - removed the platform device ID;
>> - added PORT_GP_26() and PORT_GP_28() macros, used them for GPIO1/5/6 in the
>>    CPU_ALL_PORT() macto.

>     Don't apply this patch! The change above causes the driver to fail probing
> and the eventual kernel hang somehow... :-(

    OK, I think I fixed it now. But I'm going to submit the new version of 
this patch after that, in order to reuse PORT_GP_26() when defining 
PORT_GP_28()...

>> Changes in version 2:
>> - rebased the patch.

WBR, Sergei

