From: "Nobuhiro Iwamatsu" <iwamatsu@nigauri.org>
Date: Wed, 18 Jun 2008 09:43:45 +0000
Subject: Re: Change console to another UART
Message-Id: <29ab51dc0806180243h46b4373ej1e29dcf425eef994@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080617223023.GH25911@cs181133002.pp.htv.fi>
	 <1213773664.15059.26.camel@localhost.localdomain>
In-Reply-To: <1213773664.15059.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: oihana <munoz.o@ikusi.es>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

2008/6/18 oihana <munoz.o@ikusi.es>:
> Hello,
>
> I am working with a STi7109 and mb411. The STi7109 has 4 UARTs and they
> are configured by default as follow....
> - UART0 is reserved for SC0
> - UART1 is reserved for SC1
> - UART2 is reserved for console
> - UART3 is reserved for KGDB
>
> What I need is to have the Console in the UART1 because I need the UART2
> free, and I have enough with one SC (SC0).
>
> I realized that if I change on my STWorkBench the Kernel Debug
> configuration, from ttyAS0 to ttyAS1, the console comes out from the
> other serial port, but it still uses the UART2.
>
> So I tried to change the configuration in the stasc.c
> (kernel/src/drivers/serial/stasc.c).
Hmm? I could not find it.
Is this a thing peculiar to ST?
You should send an email to support of ST if so.

Best regards,
 Nobuhiro
