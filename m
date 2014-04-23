From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 23 Apr 2014 13:36:21 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: Koelsch DT serial integration prototype
Message-Id: <CANqRtoSQZ8NBRygn-we+J2Ek4vru7XzciTa9sePJEpOfTiRsmw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140421013114.3236.90868.sendpatchset@w520>
In-Reply-To: <20140421013114.3236.90868.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent, everyone,

On Wed, Apr 23, 2014 at 9:22 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> Hi Laurent,
>
> On Wed, Apr 23, 2014 at 9:00 PM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>> Hi Magnus,
>>
>> On Wednesday 23 April 2014 11:07:25 Magnus Damm wrote:
>>> On Mon, Apr 21, 2014 at 6:50 PM, Laurent Pinchart wrote:
>>> > On Monday 21 April 2014 10:31:14 Magnus Damm wrote:
>>> >> From: Magnus Damm <damm@opensource.se>
>>> >>
>>> >> A simple serial port integration prototype that happens to
>>> >> target Koelsch. Written to propose how to move one step closer
>>> >> to integrate DT support for serial ports on mach-shmobile.
>>> >
>>> > I think you've over-engineering it. I would just switch serial devices to
>>> > DT in one go, like we do for all other devices.
>>>
>>> I agree about the risk of over-engineering! =)
>>>
>>> At the same time I would like to integrate your serial DT support as soon as
>>> possible. Order wise I'd like to integrate your serial DT support before
>>> phasing out legacy board code. We can of course discuss the order, but if we
>>> first integrate serial DT then we end up with 3 different serial cases
>>
>> The fact that we even have 3 different cases (DT only, C DT reference and C
>> legacy) shows that there's a problem. We started with C code that we forked
>> into C DT reference code instead of porting the C code over to DT, and now we
>> want to keep using platform devices in the C DT reference code ? Come on...
>
> What is the problem? We need to encourage development and also provide
> a stable base. And from my point of view, you're not even supposed to
> use the C DT reference code as a developer - you should use DT-only
> board support for development.
>
> Historically we implemented DT bindings for as many devices as
> possible, but since SCIF and timers lacked DT bindings we used
> platform devices for them to allow early DT development of other
> devices even though DT bindings for some devices were missing.
>
>> What's the next step, introducing new C DT reference-but-better board files ?
>> :-) The C DT reference board files need to be ported to DT or dropped
>> altogether right now. Any intermediate solution is just asking for trouble.
>
> Please tell me how we are supposed to use the devices that are
> included in the C DT reference board code but lack DT bindings?
>
> I have no problem switching over to DT, but unless bindings exist it
> is difficult to move over... =)
>
>>> since legacy does not use DT for "regular devices" at all. This seems quite
>>> messy in my mind, so with this proposal I hope to let all us upstream
>>> developers focus on the "DT-only board code" case that should move forward
>>> unrestricted, and at the same time keep the C board code as-is serial port
>>> wise but also start phasing out more aggressively.
>>>
>>> I'm also considering handling timers the same. The point is to allow
>>> unrestricted development of "DT-only board code" and still limit the
>>> amount of churn for legacy to a bare minimum.
>>
>> Seriously ? Count me out on that...
>
> From my point of view it makes most sense to
> - add DT bindings for devices that lack them
> - get rid of C board code
>
> But until we have DT bindings
> - keep using what we have without breakage
>
> Which portion is it that you dislike?

Now after some negotiation over chat Laurent and I have come to the
following conclusion:

Our proposed way forward for the upcoming SCIF DT integration is:
- keeping the existing serial port order
- requiring a DTB upgrade for DT reference C code
- keeping legacy C board code as-is

Laurent said he will update his DT integration patches and submit them
to the mailing list.

Regarding serial port order, it is of course important to use a
standard serial port order. To be able to share same DTB with already
existing board code we plan on adjusting the serial port order after
phasing out the legacy board code.

The following schedule has been proposed:
1. DT SCIF integration
2. DT timer integration
3. legacy board code removal
4. SCIF reordering

If there are any concerns about this please let me know. Otherwise I
propose we follow the plan above.

Cheers,

/ magnus
