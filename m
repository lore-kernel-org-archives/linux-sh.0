From: oihana <munoz.o@ikusi.es>
Date: Wed, 18 Jun 2008 07:21:04 +0000
Subject: Change console to another UART
Message-Id: <1213773664.15059.26.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <20080617223023.GH25911@cs181133002.pp.htv.fi>
In-Reply-To: <20080617223023.GH25911@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, 

I am working with a STi7109 and mb411. The STi7109 has 4 UARTs and they
are configured by default as follow....
- UART0 is reserved for SC0
- UART1 is reserved for SC1
- UART2 is reserved for console
- UART3 is reserved for KGDB

What I need is to have the Console in the UART1 because I need the UART2
free, and I have enough with one SC (SC0). 

I realized that if I change on my STWorkBench the Kernel Debug
configuration, from ttyAS0 to ttyAS1, the console comes out from the
other serial port, but it still uses the UART2. 

So I tried to change the configuration in the stasc.c
(kernel/src/drivers/serial/stasc.c).

- Original configuration for my chip and board:
struct asc_port asc_ports[ASC_NPORTS] = {
#if defined(CONFIG_CPU_SUBTYPE_STB7100)
        /* UART2 */ 
	
	{  
		.port	= {
			.membase	= (void *)0xb8032000,
			.mapbase	= 0xb8032000,
			.iotype		= SERIAL_IO_MEM,
			.irq		= 121,
			.ops		= &asc_uart_ops,
			.flags		= ASYNC_BOOT_AUTOCONF,
			.fifosize	= FIFO_SIZE,
			.line		= 0,
		},
		.pio_port	= 4, 
		.pio_pin	= {3, 2, 4, 5},
	} ,
			 
	
	/* UART3 */
	{   
		.port	= {
			.membase	= (void *)0xb8033000,
			.mapbase	= 0xb8033000,
			.iotype		= SERIAL_IO_MEM,
			.irq		= 120,
			.ops		= &asc_uart_ops,
			.flags		= ASYNC_BOOT_AUTOCONF,
			.fifosize	= FIFO_SIZE,
			.line		= 1,
		},
		.pio_port	= 5, 
		.pio_pin	= {0, 1, 2, 3},
	}
...
...


- My changes: I tried to change the order, to have in the first element
the UART3 and in the second the UART2, or to have UART1 and UART2....
and nothing seams to work. 

        /* UART1 */
	{   
		.port	= {
			.membase	= (void *)0xb8031000,
			.mapbase	= 0xb8031000,
			.iotype		= SERIAL_IO_MEM,
			.irq		= 122,
			.ops		= &asc_uart_ops,
			.flags		= ASYNC_BOOT_AUTOCONF,
			.fifosize	= FIFO_SIZE,
			.line		= 1,
		},
		.pio_port	= 1, 
		.pio_pin	= {0, 1, 4, 5},
	},
	
	/* UART2 */  
	{  
		.port	= {
			.membase	= (void *)0xb8032000,
			.mapbase	= 0xb8032000,
			.iotype		= SERIAL_IO_MEM,
			.irq		= 121,
			.ops		= &asc_uart_ops,
			.flags		= ASYNC_BOOT_AUTOCONF,
			.fifosize	= FIFO_SIZE,
			.line		= 0,
		},
		.pio_port	= 4, 
		.pio_pin	= {3, 2, 4, 5},
	} 

If the first element is the UART2, the kernel runs OK. So that I can go
into using the minicom or ssh. In the other hand, if the UART2 is the
second element, kernel seams if it was run (in the STWorkBench)... but
the ethernet ping to the board tells me "Destination Host Unreachable",
and I don't get any answer from the 3 serial points in which i
listen... 

Could someone help me please????????

Thanks, 

Oihana
