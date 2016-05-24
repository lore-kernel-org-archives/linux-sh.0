From: Marc Zyngier <marc.zyngier@arm.com>
Date: Tue, 24 May 2016 08:09:41 +0000
Subject: Re: [PATCH v2 03/12] of: add J-Core interrupt controller bindings
Message-Id: <57440C45.5040105@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1463708766.git.dalias@libc.org>
 <2bdca4260d5bb2b3820e4309e2ba445c4c7bfbf6.1463708766.git.dalias@libc.org>
 <20160523205320.GA21655@rob-hp-laptop>
 <20160523211342.GG21636@brightrain.aerifal.cx>
In-Reply-To: <20160523211342.GG21636-C3MtFaGISjmo6RMmaWD+6Sb1p8zYI1N1@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

On 23/05/16 22:13, Rich Felker wrote:
> On Mon, May 23, 2016 at 03:53:20PM -0500, Rob Herring wrote:
>> On Fri, May 20, 2016 at 02:53:04AM +0000, Rich Felker wrote:
>>> Signed-off-by: Rich Felker <dalias@libc.org>
>>> ---
>>>  .../bindings/interrupt-controller/jcore,aic.txt    | 28 ++++++++++++++++++++++
>>>  1 file changed, 28 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt b/Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt
>>> new file mode 100644
>>> index 0000000..dc9fde8
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt
>>> @@ -0,0 +1,28 @@
>>> +J-Core Advanced Interrupt Controller
>>> +
>>> +Required properties:
>>> +
>>> +- compatible : Should be "jcore,aic1" for the (obsolete) first-generation aic
>>> +  with 8 interrupt lines with programmable priorities, or "jcore,aic2" for
>>> +  the "aic2" core with 64 interrupts.
>>> +
>>> +- interrupt-controller : Identifies the node as an interrupt controller
>>> +
>>> +- #interrupt-cells : Specifies the number of cells needed to encode an
>>> +  interrupt source. The value shall be 1.
>>
>> No level/edge support? Need 2 cells if so.
> 
> No, all the logic is in hardware. From the software side you just need
> handle_simple_irq or equivalent.

Not even an EOI?

	M.
-- 
Jazz is not dead. It just smells funny...
