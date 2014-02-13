From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 13 Feb 2014 18:08:49 +0000
Subject: Re: [PATCH 1/3] clk: add clock-indices support
Message-Id: <52FD0A31.5050309@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1392314571-30107-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1392314571-30107-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 13/02/14 19:08, Sergei Shtylyov wrote:
> Hello.
>
> On 02/13/2014 09:02 PM, Ben Dooks wrote:
>
>> Add a property called clock-indices to allow clock-output-names
>> to be used where the index used to lookup a clock is not a 1:1
>> mapping to the array position in the clock-output-names
>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>>   .../devicetree/bindings/clock/clock-bindings.txt     | 17
>> +++++++++++++++++
>>   drivers/clk/clk.c                                    | 20
>> +++++++++++++++++++-
>>   2 files changed, 36 insertions(+), 1 deletion(-)
>
>> diff --git
>> a/Documentation/devicetree/bindings/clock/clock-bindings.txt
>> b/Documentation/devicetree/bindings/clock/clock-bindings.txt
>> index 7c52c29..700e7aa 100644
>> --- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
>> @@ -44,6 +44,23 @@ For example:
>>     clocks by index. The names should reflect the clock output signal
>>     names for the device.
>>
>> +clock-indices:       If the identifyng number for the clocks in the node
>> +           is not linear from zero, then the this mapping allows
>> +           the mapping of identifiers into the clock-output-names
>> +           array.
>> +
>> +For example, if we have two clocks <&oscillator 1> and <&oscillator 3>:
>> +
>> +    oscillator {
>> +        compatible = "myclocktype";
>> +        #clock-cells = <1>;
>> +        clock-indices = <1>, <3>;
>> +        clock-output-names = "clka", "clkb";
>> +    }
>> +
>> +    This ensures we do not have any empty nodes in clock-output-names
>
>     You mean empty strings?

Yes, thanks. Empty strings.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
