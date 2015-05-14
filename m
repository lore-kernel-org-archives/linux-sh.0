From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Thu, 14 May 2015 09:27:10 +0000
Subject: Re: [Bug Report] DU: Error messages at boot log and can't show image on RGB Display.
Message-Id: <55546A6E.3020809@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <5552F298.2020201@jinso.co.jp>
In-Reply-To: <5552F298.2020201@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hi Laurent-san,

On 2015年05月14日 12:18, Cao Minh Hiep wrote:
> Hi Laurent-san,
>
> I'd like to report some more informations
>
> On 2015年05月14日 06:56, Laurent Pinchart wrote:
>> Hello,
>>
>> On Wednesday 13 May 2015 15:43:36 Cao Minh Hiep wrote:
>>> Hi All.
>>>
>>> We are testing Linux upstream version-4.1-rc2 on Lager.
>>> We found a Error message of DU(Display Unit) at boot logs:
>>> The Warning messages is showed as below:
>>> "rcar-du feb00000.display: encoder initialization failed, skipping"
>>> Then we tried to show a .bmp image on RGB Display via RGB port. But it
>>> didn't work.
>>>
>>> Testing method:
>>> 1. Connect RGB Display to RGB port on Lager.
>>> 2. Show a BMP image on Display by this command:
>>> # bmap /dev/fb0 ./image.bmp
>>>
>>> We'd like to report this problem first.
>>> There are no error message at version v4.0 stable.
>>> And showed the image on RGB Display normally at version v4.0 stable.
>>> We are looking for the error patch that added between v4.0 and 
>>> v4.1-rc2.
>> I've tried v4.1-rc2 and haven't experienced that problem. It might be 
>> related
>> to kernel configuration, could you please share your .config file ?
>>
>
> We found that, if revert these patches then rebuild kernel, the error 
> logs "encoder initialization failed..." will be disappeared:
> 26c00ab ARM: shmobile: lager: Add DU external pixel clocks to DT
> fd25cdd ARM: shmobile: lager: Add DU HDMI output support
> These patch added between v4.0 and v4.1-rc2.
> But with this test, a bmp image still could not show on RGB Display.
>
We used "git log" as below to get the change patches from v4.0 to v4.1-rc2:

#git log --oneline --no-merges v4.0..v4.1-rc1 drivers/gpu/drm/rcar-du/

Firstly, We reverted all of them and re-build kernel. This case we could 
show a bmp image on RGB Display.
Next, we add each patch from bottom to up then tested.
We found that when added the commit "8b37c32 drm: rcar-du: Don't set 
connector->encoder at init time".
we could not show image on Display any more.

Jinso/Hiep.

==================

jinso02@jinso02:~/WORK/linux$ git log --oneline --no-merges 
v4.0..v4.1-rc1 drivers/gpu/drm/rcar-du/
4af642d drm/rcar-du: use for_each_endpoint_of_node macro
6dbe686 drm: rcar-du: Enable the atomic updates API
3515a9a drm: rcar-du: Don't initialize event->pipe field
de115fac drm: rcar-du: Fix framebuffer reference leak through plane state
5ee5a81 drm: rcar-du: Fix race condition in hardware plane allocator
48596d5 drm: rcar-du: Move group locking inside rcar_du_crtc_update_planes()
52055ba drm: rcar-du: Move plane commit code from CRTC start to CRTC resume
5bfcbce drm: rcar-du: Move plane format to plane state
53dff60 drm: rcar-du: Remove unneeded rcar_du_crtc plane field
4709419 drm: rcar-du: Replace plane crtc and enabled fields by plane state
f398f34 drm: rcar-du: Rework plane setup code
4407cc0 drm: rcar-du: Switch plane set_property to atomic helpers
d574664 drm: rcar-du: Switch page flip to atomic helpers
8d3f9b2 drm: rcar-du: Implement asynchronous commit support
ede7714 drm: rcar-du: Replace encoder mode_fixup with atomic_check
f348323 drm: rcar-du: Switch connector DPMS to atomic helpers
cf1cc6f drm: rcar-du: Switch mode config to atomic helpers
336d04a drm: rcar-du: Switch plane update to atomic helpers
beff155 drm: rcar-du: Rework CRTC enable/disable for atomic updates
58706b8 drm: rcar-du: Rework HDMI encoder enable/disable for atomic updates
f6638b6 drm: rcar-du: Rework encoder enable/disable for atomic updates
44ef7ed drm: rcar-du: Replace LVDS encoder DPMS by enable/disable
287bdf0 drm: rcar-du: Remove private copy of plane size and position
3e8da87 drm: rcar-du: Wire up atomic state object scaffolding
845f463 drm: rcar-du: Handle primary plane config through atomic plane ops
920888a drm: rcar-du: Implement planes atomic operations
3053460 drm: rcar-du: Fix hardware plane allocation
917de18 drm: rcar-du: Implement universal plane support
a64b9c7 drm: rcar-du: Define macros for the max number of groups, CRTCs 
and LVDS
931b733 drm: rcar-du: Disable fbdev emulation when no connector is present
0cd90a5 drm: rcar-du: Turn vblank on/off when enabling/disabling CRTC
36693f3 drm: rcar-du: Wait for page flip completion when turning the 
CRTC off
17f6b8a drm: rcar-du: Reorder CRTC functions

Bug here:
8b37c32 drm: rcar-du: Don't set connector->encoder at init time        
                                 NG

df78222 drm: rcar-du: Remove drm_fbdev_cma_restore_mode() call at init 
time                OK
0e211da drm: rcar-du: Don't disable unused functions at init time     
                                OK
f033c0b of: Decrement refcount of previous endpoint in 
of_graph_get_next_endpoint        OK


