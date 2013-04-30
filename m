From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 30 Apr 2013 20:18:43 +0000
Subject: Re: [PATCH v2] sh_eth: use random MAC address if no valid one supplied
Message-Id: <51802723.9020105@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304292349.43251.sergei.shtylyov@cogentembedded.com> <20130430.153729.859998606300915403.davem@davemloft.net>
In-Reply-To: <20130430.153729.859998606300915403.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

On 04/30/2013 11:37 PM, David Miller wrote:

>
>> On Renesas R-Car based development boards, although a MAC address is printed on
>> all the Ethernet port labels, U-Boot  doesn't write a valid MAC address  to the
>> Ether MAHR/MALR registers (there's no storage provided for the Ether MAC address
>> either), so we have to resort to using a random MAC address...
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Applied, thanks.

     Thanks to you. I thought I'll have to wait after merge window 
closes now... :-)

WBR, Sergei

