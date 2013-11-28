From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 28 Nov 2013 17:11:48 +0000
Subject: Re: [PATCH 03/04] ARM: shmobile: Genmai I2C-over-GPIO support
Message-Id: <52977954.20006@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20131127082736.20015.21303.sendpatchset@w520>
 <20131127082805.20015.82680.sendpatchset@w520> <20131127110413.GA2603@katana>
In-Reply-To: <20131127110413.GA2603@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 27-11-2013 15:04, Wolfram Sang wrote:

>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		eeprom: 24c128@50 {
>> +			compatible = "at,24c128";

> Minor nit: Should be a vendor name, not the name of the driver

    Moreover, the node should be named generically, like "flash@50", not 
"24c128@50".

WBR, Sergei

