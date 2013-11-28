From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 28 Nov 2013 18:13:06 +0000
Subject: Re: [PATCH 03/04] ARM: shmobile: Genmai I2C-over-GPIO support
Message-Id: <529787B2.7010208@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20131127082736.20015.21303.sendpatchset@w520>
 <20131127110413.GA2603@katana> <52977954.20006@cogentembedded.com>
 <4401360.Outsal0mcb@avalon>
In-Reply-To: <4401360.Outsal0mcb@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 28-11-2013 21:14, Laurent Pinchart wrote:

>>>> +		#address-cells = <1>;
>>>> +		#size-cells = <0>;
>>>> +
>>>> +		eeprom: 24c128@50 {
>>>> +			compatible = "at,24c128";

>>> Minor nit: Should be a vendor name, not the name of the driver

>> Moreover, the node should be named generically, like "flash@50", not
>> "24c128@50".

> Or, given that it's an eeprom, "eeprom@50" ? :-)

    At least ePAPR spec. only has "flash".

WBR, Sergei


