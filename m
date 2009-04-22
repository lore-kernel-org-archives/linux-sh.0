From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Date: Wed, 22 Apr 2009 11:33:53 +0000
Subject: Re: [RFC patch] sci_tx_empty for scif serial device
Message-Id: <49EF00A1.9080004@gandalf.sssup.it>
List-Id: <linux-sh.vger.kernel.org>
References: <20090421120846.GA26186@gandalf.sssup.it>
In-Reply-To: <20090421120846.GA26186@gandalf.sssup.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

Michael Trimarchi wrote:
> Hi,
>
> Paul Mundt wrote:
>> On Tue, Apr 21, 2009 at 02:08:47PM +0200, Michael Trimarchi wrote:
>>  
>>> Add the sci_tx_empty function for scif serial device.
>>>
>>> Signed-off-by: Michael Trimarchi <trimarchi@gandalf.sssup.it>
>>> ---
>>> diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
>>> index dbf5357..6cea2c4 100644
>>> --- a/drivers/serial/sh-sci.c
>>> +++ b/drivers/serial/sh-sci.c
>>> @@ -794,6 +794,20 @@ static void sci_free_irq(struct sci_port *port)
>>>  
>>>  static unsigned int sci_tx_empty(struct uart_port *port)
>>>  {
>>> +    int txroom = SCIF_TXROOM_MAX;
>>> +
>>> +#if defined(CONFIG_CPU_SUBTYPE_SH7763)
>>> +    if (!(port->mapbase = 0xffe00000) &&
>>> +        !(port->mapbase = 0xffe08000)) {
>>> +        txroom = SCIF2_TXROOM_MAX)
>>> +    }
>>> +#endif
>>>     
>>
>> Uhm.. your version of gcc must be orders of magnitude more magical than
>> mine, as I see no way for this to compile :-)
>>   
> Of course is wrong here, I don't try the SH7763 configuration. Sorry...
>>  
>>> +    if (port->type = PORT_SCIF) {
>>> +        if (scif_txroom(port) = txroom)
>>> +            return TIOCSER_TEMT;
>>> +        return 0;
>>> +    }
>>> +
>>>     
>> This looks ok anyways, is there some reason this can't be applied to
>> SH7763, too?
>>
>>   
> Apart the compilation issue, the sh7763 has the SCIF2 port has a 
> txroom different.
>
> I would like to know if it is correct that the fifosize of serial 
> device may equal to the
> tx buffer size. In this case I can change the txroom and tx_empty 
> using this info from
> the port strucy for scif device. For the sci device I don't think that 
> it is useful to read the tx status register to check if it's empty or 
> full, maybe no.
>
> Michael
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
Somenthing like this. It is just an example.

diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
index dbf5357..50563af 100644
--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -283,13 +283,9 @@ static inline void sci_init_pins(struct uart_port 
*port, unsigned int cflag)
 }
 #endif
 
-#if defined(CONFIG_CPU_SUBTYPE_SH7760) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7780) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7785) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7786)
 static inline int scif_txroom(struct uart_port *port)
 {
-    return SCIF_TXROOM_MAX - (sci_in(port, SCTFDR) & 0xff);
+    return port->fifosize - (sci_in(port, SCTFDR) & 0xff);
 }
 
 static inline int scif_rxroom(struct uart_port *port)
@@ -297,18 +293,6 @@ static inline int scif_rxroom(struct uart_port *port)
     return sci_in(port, SCRFDR) & 0xff;
 }
 #elif defined(CONFIG_CPU_SUBTYPE_SH7763)
-static inline int scif_txroom(struct uart_port *port)
-{
-    if ((port->mapbase = 0xffe00000) ||
-        (port->mapbase = 0xffe08000)) {
-        /* SCIF0/1*/
-        return SCIF_TXROOM_MAX - (sci_in(port, SCTFDR) & 0xff);
-    } else {
-        /* SCIF2 */
-        return SCIF2_TXROOM_MAX - (sci_in(port, SCFDR) >> 8);
-    }
-}
-
 static inline int scif_rxroom(struct uart_port *port)
 {
     if ((port->mapbase = 0xffe00000) ||
@@ -321,10 +305,6 @@ static inline int scif_rxroom(struct uart_port *port)
     }
 }
 #else
-static inline int scif_txroom(struct uart_port *port)
-{
-    return SCIF_TXROOM_MAX - (sci_in(port, SCFDR) >> 8);
-}
 
 static inline int scif_rxroom(struct uart_port *port)
 {
@@ -794,6 +774,12 @@ static void sci_free_irq(struct sci_port *port)
 
 static unsigned int sci_tx_empty(struct uart_port *port)
 {
+    if (port->type = PORT_SCIF) {
+        if (scif_txroom(port) = port->fifosize)
+            return TIOCSER_TEMT;
+        return 0;
+    }
+
     /* Can't detect */
     return TIOCSER_TEMT;
 }
@@ -1255,6 +1241,7 @@ static int __devinit sci_probe(struct 
platform_device *dev)
         sciport->port.irq    = p->irqs[SCIx_TXI_IRQ];
         sciport->port.flags    = p->flags;
         sciport->port.dev    = &dev->dev;
+        sciport->port.fifosize    = p->fifosize;
 
         sciport->type        = sciport->port.type = p->type;
 
