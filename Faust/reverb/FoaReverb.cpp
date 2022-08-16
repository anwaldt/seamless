/* ------------------------------------------------------------
name: "FoaReverb"
Code generated with Faust 2.40.0 (https://faust.grame.fr)
Compilation options: -a /usr/local/share/faust/supercollider.cpp -lang cpp -i -es 1 -mcd 16 -single -ftz 0
------------------------------------------------------------ */

#ifndef  __mydsp_H__
#define  __mydsp_H__

/************************************************************************
 IMPORTANT NOTE : this file contains two clearly delimited sections :
 the ARCHITECTURE section (in two parts) and the USER section. Each section
 is governed by its own copyright and license. Please check individually
 each section for license and copyright information.
 *************************************************************************/

/******************* BEGIN supercollider.cpp ****************/
/************************************************************************
 FAUST Architecture File
 Copyright (C) 2005-2012 Stefan Kersten.
 Copyright (C) 2003-2019 GRAME, Centre National de Creation Musicale
 ---------------------------------------------------------------------
 This Architecture section is free software; you can redistribute it
 and/or modify it under the terms of the GNU General Public License
 as published by the Free Software Foundation; either version 3 of
 the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; If not, see <http://www.gnu.org/licenses/>.
 
 EXCEPTION : As a special exception, you may create a larger work
 that contains this FAUST architecture section and distribute
 that work under terms of your choice, so long as this FAUST
 architecture section is not modified.
 
 ************************************************************************
 ************************************************************************/

// The prefix is set to "Faust" in the faust2supercollider script, otherwise set empty
#if !defined(SC_FAUST_PREFIX)
#define SC_FAUST_PREFIX ""
#endif

#include <map>
#include <string>
#include <string.h>
#include <SC_PlugIn.h>

/************************** BEGIN dsp.h ********************************
 FAUST Architecture File
 Copyright (C) 2003-2022 GRAME, Centre National de Creation Musicale
 ---------------------------------------------------------------------
 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU Lesser General Public License as published by
 the Free Software Foundation; either version 2.1 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 GNU Lesser General Public License for more details.
 
 You should have received a copy of the GNU Lesser General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 
 EXCEPTION : As a special exception, you may create a larger work
 that contains this FAUST architecture section and distribute
 that work under terms of your choice, so long as this FAUST
 architecture section is not modified.
 ************************************************************************/

#ifndef __dsp__
#define __dsp__

#include <string>
#include <vector>

#ifndef FAUSTFLOAT
#define FAUSTFLOAT float
#endif

struct UI;
struct Meta;

/**
 * DSP memory manager.
 */

struct dsp_memory_manager {
    
    virtual ~dsp_memory_manager() {}
    
    /**
     * Inform the Memory Manager with the number of expected memory zones.
     * @param count - the number of expected memory zones
     */
    virtual void begin(size_t count) {}
    
    /**
     * Give the Memory Manager information on a given memory zone.
     * @param size - the size in bytes of the memory zone
     * @param reads - the number of Read access to the zone used to compute one frame
     * @param writes - the number of Write access to the zone used to compute one frame
     */
    virtual void info(size_t size, size_t reads, size_t writes) {}
    
    /**
     * Inform the Memory Manager that all memory zones have been described,
     * to possibly start a 'compute the best allocation strategy' step.
     */
    virtual void end() {}
    
    /**
     * Allocate a memory zone.
     * @param size - the memory zone size in bytes
     */
    virtual void* allocate(size_t size) = 0;
    
    /**
     * Destroy a memory zone.
     * @param ptr - the memory zone pointer to be deallocated
     */
    virtual void destroy(void* ptr) = 0;
    
};

/**
* Signal processor definition.
*/

class dsp {

    public:

        dsp() {}
        virtual ~dsp() {}

        /* Return instance number of audio inputs */
        virtual int getNumInputs() = 0;
    
        /* Return instance number of audio outputs */
        virtual int getNumOutputs() = 0;
    
        /**
         * Trigger the ui_interface parameter with instance specific calls
         * to 'openTabBox', 'addButton', 'addVerticalSlider'... in order to build the UI.
         *
         * @param ui_interface - the user interface builder
         */
        virtual void buildUserInterface(UI* ui_interface) = 0;
    
        /* Return the sample rate currently used by the instance */
        virtual int getSampleRate() = 0;
    
        /**
         * Global init, calls the following methods:
         * - static class 'classInit': static tables initialization
         * - 'instanceInit': constants and instance state initialization
         *
         * @param sample_rate - the sampling rate in Hz
         */
        virtual void init(int sample_rate) = 0;

        /**
         * Init instance state
         *
         * @param sample_rate - the sampling rate in Hz
         */
        virtual void instanceInit(int sample_rate) = 0;
    
        /**
         * Init instance constant state
         *
         * @param sample_rate - the sampling rate in Hz
         */
        virtual void instanceConstants(int sample_rate) = 0;
    
        /* Init default control parameters values */
        virtual void instanceResetUserInterface() = 0;
    
        /* Init instance state (like delay lines...) but keep the control parameter values */
        virtual void instanceClear() = 0;
 
        /**
         * Return a clone of the instance.
         *
         * @return a copy of the instance on success, otherwise a null pointer.
         */
        virtual dsp* clone() = 0;
    
        /**
         * Trigger the Meta* parameter with instance specific calls to 'declare' (key, value) metadata.
         *
         * @param m - the Meta* meta user
         */
        virtual void metadata(Meta* m) = 0;
    
        /**
         * DSP instance computation, to be called with successive in/out audio buffers.
         *
         * @param count - the number of frames to compute
         * @param inputs - the input audio buffers as an array of non-interleaved FAUSTFLOAT samples (eiher float, double or quad)
         * @param outputs - the output audio buffers as an array of non-interleaved FAUSTFLOAT samples (eiher float, double or quad)
         *
         */
        virtual void compute(int count, FAUSTFLOAT** inputs, FAUSTFLOAT** outputs) = 0;
    
        /**
         * DSP instance computation: alternative method to be used by subclasses.
         *
         * @param date_usec - the timestamp in microsec given by audio driver.
         * @param count - the number of frames to compute
         * @param inputs - the input audio buffers as an array of non-interleaved FAUSTFLOAT samples (either float, double or quad)
         * @param outputs - the output audio buffers as an array of non-interleaved FAUSTFLOAT samples (either float, double or quad)
         *
         */
        virtual void compute(double /*date_usec*/, int count, FAUSTFLOAT** inputs, FAUSTFLOAT** outputs) { compute(count, inputs, outputs); }
       
};

/**
 * Generic DSP decorator.
 */

class decorator_dsp : public dsp {

    protected:

        dsp* fDSP;

    public:

        decorator_dsp(dsp* dsp = nullptr):fDSP(dsp) {}
        virtual ~decorator_dsp() { delete fDSP; }

        virtual int getNumInputs() { return fDSP->getNumInputs(); }
        virtual int getNumOutputs() { return fDSP->getNumOutputs(); }
        virtual void buildUserInterface(UI* ui_interface) { fDSP->buildUserInterface(ui_interface); }
        virtual int getSampleRate() { return fDSP->getSampleRate(); }
        virtual void init(int sample_rate) { fDSP->init(sample_rate); }
        virtual void instanceInit(int sample_rate) { fDSP->instanceInit(sample_rate); }
        virtual void instanceConstants(int sample_rate) { fDSP->instanceConstants(sample_rate); }
        virtual void instanceResetUserInterface() { fDSP->instanceResetUserInterface(); }
        virtual void instanceClear() { fDSP->instanceClear(); }
        virtual decorator_dsp* clone() { return new decorator_dsp(fDSP->clone()); }
        virtual void metadata(Meta* m) { fDSP->metadata(m); }
        // Beware: subclasses usually have to overload the two 'compute' methods
        virtual void compute(int count, FAUSTFLOAT** inputs, FAUSTFLOAT** outputs) { fDSP->compute(count, inputs, outputs); }
        virtual void compute(double date_usec, int count, FAUSTFLOAT** inputs, FAUSTFLOAT** outputs) { fDSP->compute(date_usec, count, inputs, outputs); }
    
};

/**
 * DSP factory class, used with LLVM and Interpreter backends
 * to create DSP instances from a compiled DSP program.
 */

class dsp_factory {
    
    protected:
    
        // So that to force sub-classes to use deleteDSPFactory(dsp_factory* factory);
        virtual ~dsp_factory() {}
    
    public:
    
        virtual std::string getName() = 0;
        virtual std::string getSHAKey() = 0;
        virtual std::string getDSPCode() = 0;
        virtual std::string getCompileOptions() = 0;
        virtual std::vector<std::string> getLibraryList() = 0;
        virtual std::vector<std::string> getIncludePathnames() = 0;
    
        virtual dsp* createDSPInstance() = 0;
    
        virtual void setMemoryManager(dsp_memory_manager* manager) = 0;
        virtual dsp_memory_manager* getMemoryManager() = 0;
    
};

// Denormal handling

#if defined (__SSE__)
#include <xmmintrin.h>
#endif

class ScopedNoDenormals
{
    private:
    
        intptr_t fpsr;
        
        void setFpStatusRegister(intptr_t fpsr_aux) noexcept
        {
        #if defined (__arm64__) || defined (__aarch64__)
           asm volatile("msr fpcr, %0" : : "ri" (fpsr_aux));
        #elif defined (__SSE__)
            _mm_setcsr(static_cast<uint32_t>(fpsr_aux));
        #endif
        }
        
        void getFpStatusRegister() noexcept
        {
        #if defined (__arm64__) || defined (__aarch64__)
            asm volatile("mrs %0, fpcr" : "=r" (fpsr));
        #elif defined ( __SSE__)
            fpsr = static_cast<intptr_t>(_mm_getcsr());
        #endif
        }
    
    public:
    
        ScopedNoDenormals() noexcept
        {
        #if defined (__arm64__) || defined (__aarch64__)
            intptr_t mask = (1 << 24 /* FZ */);
        #else
            #if defined(__SSE__)
            #if defined(__SSE2__)
                intptr_t mask = 0x8040;
            #else
                intptr_t mask = 0x8000;
            #endif
            #else
                intptr_t mask = 0x0000;
            #endif
        #endif
            getFpStatusRegister();
            setFpStatusRegister(fpsr | mask);
        }
        
        ~ScopedNoDenormals() noexcept
        {
            setFpStatusRegister(fpsr);
        }

};

#define AVOIDDENORMALS ScopedNoDenormals();

#endif

/************************** END dsp.h **************************/
/************************** BEGIN UI.h *****************************
 FAUST Architecture File
 Copyright (C) 2003-2022 GRAME, Centre National de Creation Musicale
 ---------------------------------------------------------------------
 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU Lesser General Public License as published by
 the Free Software Foundation; either version 2.1 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 GNU Lesser General Public License for more details.
 
 You should have received a copy of the GNU Lesser General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 
 EXCEPTION : As a special exception, you may create a larger work
 that contains this FAUST architecture section and distribute
 that work under terms of your choice, so long as this FAUST
 architecture section is not modified.
 ********************************************************************/

#ifndef __UI_H__
#define __UI_H__

#ifndef FAUSTFLOAT
#define FAUSTFLOAT float
#endif

/*******************************************************************************
 * UI : Faust DSP User Interface
 * User Interface as expected by the buildUserInterface() method of a DSP.
 * This abstract class contains only the method that the Faust compiler can
 * generate to describe a DSP user interface.
 ******************************************************************************/

struct Soundfile;

template <typename REAL>
struct UIReal
{
    UIReal() {}
    virtual ~UIReal() {}
    
    // -- widget's layouts
    
    virtual void openTabBox(const char* label) = 0;
    virtual void openHorizontalBox(const char* label) = 0;
    virtual void openVerticalBox(const char* label) = 0;
    virtual void closeBox() = 0;
    
    // -- active widgets
    
    virtual void addButton(const char* label, REAL* zone) = 0;
    virtual void addCheckButton(const char* label, REAL* zone) = 0;
    virtual void addVerticalSlider(const char* label, REAL* zone, REAL init, REAL min, REAL max, REAL step) = 0;
    virtual void addHorizontalSlider(const char* label, REAL* zone, REAL init, REAL min, REAL max, REAL step) = 0;
    virtual void addNumEntry(const char* label, REAL* zone, REAL init, REAL min, REAL max, REAL step) = 0;
    
    // -- passive widgets
    
    virtual void addHorizontalBargraph(const char* label, REAL* zone, REAL min, REAL max) = 0;
    virtual void addVerticalBargraph(const char* label, REAL* zone, REAL min, REAL max) = 0;
    
    // -- soundfiles
    
    virtual void addSoundfile(const char* label, const char* filename, Soundfile** sf_zone) = 0;
    
    // -- metadata declarations
    
    virtual void declare(REAL* zone, const char* key, const char* val) {}
    
    // To be used by LLVM client
    virtual int sizeOfFAUSTFLOAT() { return sizeof(FAUSTFLOAT); }
};

struct UI : public UIReal<FAUSTFLOAT>
{
    UI() {}
    virtual ~UI() {}
};

#endif
/**************************  END  UI.h **************************/
/************************** BEGIN misc.h *******************************
FAUST Architecture File
Copyright (C) 2003-2022 GRAME, Centre National de Creation Musicale
---------------------------------------------------------------------
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation; either version 2.1 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

EXCEPTION : As a special exception, you may create a larger work
that contains this FAUST architecture section and distribute
that work under terms of your choice, so long as this FAUST
architecture section is not modified.
***************************************************************************/

#ifndef __misc__
#define __misc__

#include <algorithm>
#include <map>
#include <cstdlib>
#include <string.h>
#include <fstream>
#include <string>

/************************** BEGIN meta.h *******************************
 FAUST Architecture File
 Copyright (C) 2003-2022 GRAME, Centre National de Creation Musicale
 ---------------------------------------------------------------------
 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU Lesser General Public License as published by
 the Free Software Foundation; either version 2.1 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 GNU Lesser General Public License for more details.
 
 You should have received a copy of the GNU Lesser General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 
 EXCEPTION : As a special exception, you may create a larger work
 that contains this FAUST architecture section and distribute
 that work under terms of your choice, so long as this FAUST
 architecture section is not modified.
 ************************************************************************/

#ifndef __meta__
#define __meta__

/**
 The base class of Meta handler to be used in dsp::metadata(Meta* m) method to retrieve (key, value) metadata.
 */
struct Meta
{
    virtual ~Meta() {}
    virtual void declare(const char* key, const char* value) = 0;
};

#endif
/**************************  END  meta.h **************************/

struct MY_Meta : Meta, std::map<const char*, const char*>
{
    void declare(const char* key, const char* value) { (*this)[key] = value; }
};

static int lsr(int x, int n) { return int(((unsigned int)x) >> n); }

static int int2pow2(int x) { int r = 0; while ((1<<r) < x) r++; return r; }

static long lopt(char* argv[], const char* name, long def)
{
    for (int i = 0; argv[i]; i++) if (!strcmp(argv[i], name)) return std::atoi(argv[i+1]);
    return def;
}

static long lopt1(int argc, char* argv[], const char* longname, const char* shortname, long def)
{
    for (int i = 2; i < argc; i++) {
        if (strcmp(argv[i-1], shortname) == 0 || strcmp(argv[i-1], longname) == 0) {
            return atoi(argv[i]);
        }
    }
    return def;
}

static const char* lopts(char* argv[], const char* name, const char* def)
{
    for (int i = 0; argv[i]; i++) if (!strcmp(argv[i], name)) return argv[i+1];
    return def;
}

static const char* lopts1(int argc, char* argv[], const char* longname, const char* shortname, const char* def)
{
    for (int i = 2; i < argc; i++) {
        if (strcmp(argv[i-1], shortname) == 0 || strcmp(argv[i-1], longname) == 0) {
            return argv[i];
        }
    }
    return def;
}

static bool isopt(char* argv[], const char* name)
{
    for (int i = 0; argv[i]; i++) if (!strcmp(argv[i], name)) return true;
    return false;
}

static std::string pathToContent(const std::string& path)
{
    std::ifstream file(path.c_str(), std::ifstream::binary);
    
    file.seekg(0, file.end);
    int size = int(file.tellg());
    file.seekg(0, file.beg);
    
    // And allocate buffer to that a single line can be read...
    char* buffer = new char[size + 1];
    file.read(buffer, size);
    
    // Terminate the string
    buffer[size] = 0;
    std::string result = buffer;
    file.close();
    delete [] buffer;
    return result;
}

#endif

/**************************  END  misc.h **************************/

using namespace std;

#if defined(__GNUC__) && __GNUC__ >= 4
    #define FAUST_EXPORT __attribute__((visibility("default")))
#else
    #define FAUST_EXPORT  SC_API_EXPORT
#endif

#ifdef WIN32
    #define STRDUP _strdup
#else
    #define STRDUP strdup
#endif

//----------------------------------------------------------------------------
// Metadata
//----------------------------------------------------------------------------

class MetaData : public Meta
               , public std::map<std::string, std::string>
{
public:
    void declare(const char* key, const char* value)
    {
        (*this)[key] = value;
    }
};

//----------------------------------------------------------------------------
// Control counter
//----------------------------------------------------------------------------

class ControlCounter : public UI
{
public:
    ControlCounter()
        : mNumControlInputs(0),
          mNumControlOutputs(0)
    {}

    size_t getNumControls() const { return getNumControlInputs(); }
    size_t getNumControlInputs() const { return mNumControlInputs; }
    size_t getNumControlOutputs() const { return mNumControlOutputs; }

    // Layout widgets
    virtual void openTabBox(const char* label) { }
    virtual void openHorizontalBox(const char* label) { }
    virtual void openVerticalBox(const char* label) { }
    virtual void closeBox() { }

    // Active widgets
    virtual void addButton(const char* label, FAUSTFLOAT* zone)
    { addControlInput(); }
    virtual void addCheckButton(const char* label, FAUSTFLOAT* zone)
    { addControlInput(); }
    virtual void addVerticalSlider(const char* label, FAUSTFLOAT* zone, FAUSTFLOAT init, FAUSTFLOAT min, FAUSTFLOAT max, FAUSTFLOAT step)
    { addControlInput(); }
    virtual void addHorizontalSlider(const char* label, FAUSTFLOAT* zone, FAUSTFLOAT init, FAUSTFLOAT min, FAUSTFLOAT max, FAUSTFLOAT step)
    { addControlInput(); }
    virtual void addNumEntry(const char* label, FAUSTFLOAT* zone, FAUSTFLOAT init, FAUSTFLOAT min, FAUSTFLOAT max, FAUSTFLOAT step)
    { addControlInput(); }

    // Passive widgets
    virtual void addHorizontalBargraph(const char* label, FAUSTFLOAT* zone, FAUSTFLOAT min, FAUSTFLOAT max)
    { addControlOutput(); }
    virtual void addVerticalBargraph(const char* label, FAUSTFLOAT* zone, FAUSTFLOAT min, FAUSTFLOAT max)
    { addControlOutput(); }
    
    virtual void addSoundfile(const char* label, const char* filename, Soundfile** sf_zone) {}

protected:
    void addControlInput() { mNumControlInputs++; }
    void addControlOutput() { mNumControlOutputs++; }

private:
    size_t mNumControlInputs;
    size_t mNumControlOutputs;
};

//----------------------------------------------------------------------------
// UI control
//----------------------------------------------------------------------------

struct Control
{
    typedef void (*UpdateFunction)(Control* self, FAUSTFLOAT value);

    UpdateFunction updateFunction;
    FAUSTFLOAT* zone;
    FAUSTFLOAT min, max;

    inline void update(FAUSTFLOAT value)
    {
        (*updateFunction)(this, value);
    }

    static void simpleUpdate(Control* self, FAUSTFLOAT value)
    {
        *self->zone = value;
    }
    static void boundedUpdate(Control* self, FAUSTFLOAT value)
    {
        *self->zone = sc_clip(value, self->min, self->max);
    }
};

//----------------------------------------------------------------------------
// Control allocator
//----------------------------------------------------------------------------

class ControlAllocator : public UI
{
public:
    ControlAllocator(Control* controls)
        : mControls(controls)
    { }

    // Layout widgets
    virtual void openTabBox(const char* label) { }
    virtual void openHorizontalBox(const char* label) { }
    virtual void openVerticalBox(const char* label) { }
    virtual void closeBox() { }

    // Active widgets
    virtual void addButton(const char* label, FAUSTFLOAT* zone)
    { addSimpleControl(zone); }
    virtual void addCheckButton(const char* label, FAUSTFLOAT* zone)
    { addSimpleControl(zone); }
    virtual void addVerticalSlider(const char* label, FAUSTFLOAT* zone, FAUSTFLOAT init, FAUSTFLOAT min, FAUSTFLOAT max, FAUSTFLOAT step)
    { addBoundedControl(zone, min, max, step); }
    virtual void addHorizontalSlider(const char* label, FAUSTFLOAT* zone, FAUSTFLOAT init, FAUSTFLOAT min, FAUSTFLOAT max, FAUSTFLOAT step)
    { addBoundedControl(zone, min, max, step); }
    virtual void addNumEntry(const char* label, FAUSTFLOAT* zone, FAUSTFLOAT init, FAUSTFLOAT min, FAUSTFLOAT max, FAUSTFLOAT step)
    { addBoundedControl(zone, min, max, step); }

    // Passive widgets
    virtual void addHorizontalBargraph(const char* label, FAUSTFLOAT* zone, FAUSTFLOAT min, FAUSTFLOAT max) {}
    virtual void addVerticalBargraph(const char* label, FAUSTFLOAT* zone, FAUSTFLOAT min, FAUSTFLOAT max) {}
    virtual void addSoundfile(const char* label, const char* filename, Soundfile** sf_zone) {}

private:
    void addControl(Control::UpdateFunction updateFunction, FAUSTFLOAT* zone, FAUSTFLOAT min, FAUSTFLOAT max, FAUSTFLOAT /* step */)
    {
        Control* ctrl        = mControls++;
        ctrl->updateFunction = updateFunction;
        ctrl->zone           = zone;
        ctrl->min            = min;
        ctrl->max            = max;
    }
    void addSimpleControl(FAUSTFLOAT* zone)
    {
        addControl(Control::simpleUpdate, zone, 0.f, 0.f, 0.f);
    }
    void addBoundedControl(FAUSTFLOAT* zone, FAUSTFLOAT min, FAUSTFLOAT max, FAUSTFLOAT step)
    {
        addControl(Control::boundedUpdate, zone, min, max, step);
    }

private:
    Control* mControls;
};

/******************************************************************************
 *******************************************************************************
 
 VECTOR INTRINSICS
 
 *******************************************************************************
 *******************************************************************************/


/********************END ARCHITECTURE SECTION (part 1/2)****************/

/**************************BEGIN USER SECTION **************************/

#ifndef FAUSTFLOAT
#define FAUSTFLOAT float
#endif 

#include <algorithm>
#include <cmath>
#include <cstdint>
#include <math.h>

#ifndef FAUSTCLASS 
#define FAUSTCLASS mydsp
#endif

#ifdef __APPLE__ 
#define exp10f __exp10f
#define exp10 __exp10
#endif

#if defined(_WIN32)
#define RESTRICT __restrict
#else
#define RESTRICT __restrict__
#endif

static float mydsp_faustpower2_f(float value) {
	return value * value;
}

class mydsp : public dsp {
	
 private:
	
	int fSampleRate;
	float fConst2;
	FAUSTFLOAT fEntry0;
	float fConst3;
	FAUSTFLOAT fEntry1;
	FAUSTFLOAT fEntry2;
	float fConst4;
	FAUSTFLOAT fEntry3;
	float fRec11[2];
	float fRec10[2];
	int IOTA0;
	float fVec0[32768];
	int iConst6;
	float fVec1[16384];
	float fConst7;
	FAUSTFLOAT fEntry4;
	float fVec2[2048];
	int iConst8;
	float fRec8[2];
	float fConst10;
	float fRec15[2];
	float fRec14[2];
	float fVec3[32768];
	int iConst12;
	float fVec4[4096];
	int iConst13;
	float fRec12[2];
	float fConst15;
	float fRec19[2];
	float fRec18[2];
	float fVec5[16384];
	int iConst17;
	float fVec6[4096];
	int iConst18;
	float fRec16[2];
	float fConst20;
	float fRec23[2];
	float fRec22[2];
	float fVec7[32768];
	int iConst22;
	float fVec8[4096];
	int iConst23;
	float fRec20[2];
	float fConst25;
	float fRec27[2];
	float fRec26[2];
	float fVec9[16384];
	int iConst27;
	float fVec10[2048];
	int iConst28;
	float fRec24[2];
	float fConst30;
	float fRec31[2];
	float fRec30[2];
	float fVec11[16384];
	int iConst32;
	float fVec12[4096];
	int iConst33;
	float fRec28[2];
	float fConst35;
	float fRec35[2];
	float fRec34[2];
	float fVec13[16384];
	int iConst37;
	float fVec14[4096];
	int iConst38;
	float fRec32[2];
	float fConst40;
	float fRec39[2];
	float fRec38[2];
	float fVec15[16384];
	int iConst42;
	float fVec16[2048];
	int iConst43;
	float fRec36[2];
	float fRec0[3];
	float fRec1[3];
	float fRec2[3];
	float fRec3[3];
	float fRec4[3];
	float fRec5[3];
	float fRec6[3];
	float fRec7[3];
	FAUSTFLOAT fEntry5;
	
 public:
	
	void metadata(Meta* m) { 
		m->declare("basics.lib/name", "Faust Basic Element Library");
		m->declare("basics.lib/version", "0.5");
		m->declare("compile_options", "-a /usr/local/share/faust/supercollider.cpp -lang cpp -i -es 1 -mcd 16 -single -ftz 0");
		m->declare("delays.lib/name", "Faust Delay Library");
		m->declare("delays.lib/version", "0.1");
		m->declare("filename", "FoaReverb.dsp");
		m->declare("filters.lib/allpass_comb:author", "Julius O. Smith III");
		m->declare("filters.lib/allpass_comb:copyright", "Copyright (C) 2003-2019 by Julius O. Smith III <jos@ccrma.stanford.edu>");
		m->declare("filters.lib/allpass_comb:license", "MIT-style STK-4.3 license");
		m->declare("filters.lib/lowpass0_highpass1", "MIT-style STK-4.3 license");
		m->declare("filters.lib/lowpass0_highpass1:author", "Julius O. Smith III");
		m->declare("filters.lib/lowpass:author", "Julius O. Smith III");
		m->declare("filters.lib/lowpass:copyright", "Copyright (C) 2003-2019 by Julius O. Smith III <jos@ccrma.stanford.edu>");
		m->declare("filters.lib/lowpass:license", "MIT-style STK-4.3 license");
		m->declare("filters.lib/name", "Faust Filters Library");
		m->declare("filters.lib/tf1:author", "Julius O. Smith III");
		m->declare("filters.lib/tf1:copyright", "Copyright (C) 2003-2019 by Julius O. Smith III <jos@ccrma.stanford.edu>");
		m->declare("filters.lib/tf1:license", "MIT-style STK-4.3 license");
		m->declare("filters.lib/tf1s:author", "Julius O. Smith III");
		m->declare("filters.lib/tf1s:copyright", "Copyright (C) 2003-2019 by Julius O. Smith III <jos@ccrma.stanford.edu>");
		m->declare("filters.lib/tf1s:license", "MIT-style STK-4.3 license");
		m->declare("filters.lib/version", "0.3");
		m->declare("maths.lib/author", "GRAME");
		m->declare("maths.lib/copyright", "GRAME");
		m->declare("maths.lib/license", "LGPL with exception");
		m->declare("maths.lib/name", "Faust Math Library");
		m->declare("maths.lib/version", "2.5");
		m->declare("name", "FoaReverb");
		m->declare("platform.lib/name", "Generic Platform Library");
		m->declare("platform.lib/version", "0.2");
		m->declare("reverbs.lib/name", "Faust Reverb Library");
		m->declare("reverbs.lib/version", "0.2");
		m->declare("routes.lib/hadamard:author", "Remy Muller, revised by RM");
		m->declare("routes.lib/name", "Faust Signal Routing Library");
		m->declare("routes.lib/version", "0.2");
		m->declare("signals.lib/name", "Faust Signal Routing Library");
		m->declare("signals.lib/version", "0.1");
	}

	virtual int getNumInputs() {
		return 1;
	}
	virtual int getNumOutputs() {
		return 4;
	}
	
	static void classInit(int sample_rate) {
	}
	
	virtual void instanceConstants(int sample_rate) {
		fSampleRate = sample_rate;
		float fConst0 = std::min<float>(192000.0f, std::max<float>(1.0f, float(fSampleRate)));
		float fConst1 = std::floor(0.219990999f * fConst0 + 0.5f);
		fConst2 = (0.0f - 6.90775537f * fConst1) / fConst0;
		fConst3 = 6.28318548f / fConst0;
		fConst4 = 3.14159274f / fConst0;
		float fConst5 = std::floor(0.0191229992f * fConst0 + 0.5f);
		iConst6 = int(std::min<float>(16384.0f, std::max<float>(0.0f, fConst1 - fConst5)));
		fConst7 = 0.00100000005f * fConst0;
		iConst8 = int(std::min<float>(1024.0f, std::max<float>(0.0f, fConst5 + -1.0f)));
		float fConst9 = std::floor(0.256891012f * fConst0 + 0.5f);
		fConst10 = (0.0f - 6.90775537f * fConst9) / fConst0;
		float fConst11 = std::floor(0.0273330007f * fConst0 + 0.5f);
		iConst12 = int(std::min<float>(16384.0f, std::max<float>(0.0f, fConst9 - fConst11)));
		iConst13 = int(std::min<float>(2048.0f, std::max<float>(0.0f, fConst11 + -1.0f)));
		float fConst14 = std::floor(0.192303002f * fConst0 + 0.5f);
		fConst15 = (0.0f - 6.90775537f * fConst14) / fConst0;
		float fConst16 = std::floor(0.0292910002f * fConst0 + 0.5f);
		iConst17 = int(std::min<float>(8192.0f, std::max<float>(0.0f, fConst14 - fConst16)));
		iConst18 = int(std::min<float>(2048.0f, std::max<float>(0.0f, fConst16 + -1.0f)));
		float fConst19 = std::floor(0.210389003f * fConst0 + 0.5f);
		fConst20 = (0.0f - 6.90775537f * fConst19) / fConst0;
		float fConst21 = std::floor(0.0244210009f * fConst0 + 0.5f);
		iConst22 = int(std::min<float>(16384.0f, std::max<float>(0.0f, fConst19 - fConst21)));
		iConst23 = int(std::min<float>(2048.0f, std::max<float>(0.0f, fConst21 + -1.0f)));
		float fConst24 = std::floor(0.125f * fConst0 + 0.5f);
		fConst25 = (0.0f - 6.90775537f * fConst24) / fConst0;
		float fConst26 = std::floor(0.0134579996f * fConst0 + 0.5f);
		iConst27 = int(std::min<float>(8192.0f, std::max<float>(0.0f, fConst24 - fConst26)));
		iConst28 = int(std::min<float>(1024.0f, std::max<float>(0.0f, fConst26 + -1.0f)));
		float fConst29 = std::floor(0.127837002f * fConst0 + 0.5f);
		fConst30 = (0.0f - 6.90775537f * fConst29) / fConst0;
		float fConst31 = std::floor(0.0316039994f * fConst0 + 0.5f);
		iConst32 = int(std::min<float>(8192.0f, std::max<float>(0.0f, fConst29 - fConst31)));
		iConst33 = int(std::min<float>(2048.0f, std::max<float>(0.0f, fConst31 + -1.0f)));
		float fConst34 = std::floor(0.174713001f * fConst0 + 0.5f);
		fConst35 = (0.0f - 6.90775537f * fConst34) / fConst0;
		float fConst36 = std::floor(0.0229039993f * fConst0 + 0.5f);
		iConst37 = int(std::min<float>(8192.0f, std::max<float>(0.0f, fConst34 - fConst36)));
		iConst38 = int(std::min<float>(2048.0f, std::max<float>(0.0f, fConst36 + -1.0f)));
		float fConst39 = std::floor(0.153128996f * fConst0 + 0.5f);
		fConst40 = (0.0f - 6.90775537f * fConst39) / fConst0;
		float fConst41 = std::floor(0.0203460008f * fConst0 + 0.5f);
		iConst42 = int(std::min<float>(8192.0f, std::max<float>(0.0f, fConst39 - fConst41)));
		iConst43 = int(std::min<float>(1024.0f, std::max<float>(0.0f, fConst41 + -1.0f)));
	}
	
	virtual void instanceResetUserInterface() {
		fEntry0 = FAUSTFLOAT(4.0f);
		fEntry1 = FAUSTFLOAT(1000.0f);
		fEntry2 = FAUSTFLOAT(3.0f);
		fEntry3 = FAUSTFLOAT(300.0f);
		fEntry4 = FAUSTFLOAT(2.0f);
		fEntry5 = FAUSTFLOAT(1.0f);
	}
	
	virtual void instanceClear() {
		for (int l0 = 0; l0 < 2; l0 = l0 + 1) {
			fRec11[l0] = 0.0f;
		}
		for (int l1 = 0; l1 < 2; l1 = l1 + 1) {
			fRec10[l1] = 0.0f;
		}
		IOTA0 = 0;
		for (int l2 = 0; l2 < 32768; l2 = l2 + 1) {
			fVec0[l2] = 0.0f;
		}
		for (int l3 = 0; l3 < 16384; l3 = l3 + 1) {
			fVec1[l3] = 0.0f;
		}
		for (int l4 = 0; l4 < 2048; l4 = l4 + 1) {
			fVec2[l4] = 0.0f;
		}
		for (int l5 = 0; l5 < 2; l5 = l5 + 1) {
			fRec8[l5] = 0.0f;
		}
		for (int l6 = 0; l6 < 2; l6 = l6 + 1) {
			fRec15[l6] = 0.0f;
		}
		for (int l7 = 0; l7 < 2; l7 = l7 + 1) {
			fRec14[l7] = 0.0f;
		}
		for (int l8 = 0; l8 < 32768; l8 = l8 + 1) {
			fVec3[l8] = 0.0f;
		}
		for (int l9 = 0; l9 < 4096; l9 = l9 + 1) {
			fVec4[l9] = 0.0f;
		}
		for (int l10 = 0; l10 < 2; l10 = l10 + 1) {
			fRec12[l10] = 0.0f;
		}
		for (int l11 = 0; l11 < 2; l11 = l11 + 1) {
			fRec19[l11] = 0.0f;
		}
		for (int l12 = 0; l12 < 2; l12 = l12 + 1) {
			fRec18[l12] = 0.0f;
		}
		for (int l13 = 0; l13 < 16384; l13 = l13 + 1) {
			fVec5[l13] = 0.0f;
		}
		for (int l14 = 0; l14 < 4096; l14 = l14 + 1) {
			fVec6[l14] = 0.0f;
		}
		for (int l15 = 0; l15 < 2; l15 = l15 + 1) {
			fRec16[l15] = 0.0f;
		}
		for (int l16 = 0; l16 < 2; l16 = l16 + 1) {
			fRec23[l16] = 0.0f;
		}
		for (int l17 = 0; l17 < 2; l17 = l17 + 1) {
			fRec22[l17] = 0.0f;
		}
		for (int l18 = 0; l18 < 32768; l18 = l18 + 1) {
			fVec7[l18] = 0.0f;
		}
		for (int l19 = 0; l19 < 4096; l19 = l19 + 1) {
			fVec8[l19] = 0.0f;
		}
		for (int l20 = 0; l20 < 2; l20 = l20 + 1) {
			fRec20[l20] = 0.0f;
		}
		for (int l21 = 0; l21 < 2; l21 = l21 + 1) {
			fRec27[l21] = 0.0f;
		}
		for (int l22 = 0; l22 < 2; l22 = l22 + 1) {
			fRec26[l22] = 0.0f;
		}
		for (int l23 = 0; l23 < 16384; l23 = l23 + 1) {
			fVec9[l23] = 0.0f;
		}
		for (int l24 = 0; l24 < 2048; l24 = l24 + 1) {
			fVec10[l24] = 0.0f;
		}
		for (int l25 = 0; l25 < 2; l25 = l25 + 1) {
			fRec24[l25] = 0.0f;
		}
		for (int l26 = 0; l26 < 2; l26 = l26 + 1) {
			fRec31[l26] = 0.0f;
		}
		for (int l27 = 0; l27 < 2; l27 = l27 + 1) {
			fRec30[l27] = 0.0f;
		}
		for (int l28 = 0; l28 < 16384; l28 = l28 + 1) {
			fVec11[l28] = 0.0f;
		}
		for (int l29 = 0; l29 < 4096; l29 = l29 + 1) {
			fVec12[l29] = 0.0f;
		}
		for (int l30 = 0; l30 < 2; l30 = l30 + 1) {
			fRec28[l30] = 0.0f;
		}
		for (int l31 = 0; l31 < 2; l31 = l31 + 1) {
			fRec35[l31] = 0.0f;
		}
		for (int l32 = 0; l32 < 2; l32 = l32 + 1) {
			fRec34[l32] = 0.0f;
		}
		for (int l33 = 0; l33 < 16384; l33 = l33 + 1) {
			fVec13[l33] = 0.0f;
		}
		for (int l34 = 0; l34 < 4096; l34 = l34 + 1) {
			fVec14[l34] = 0.0f;
		}
		for (int l35 = 0; l35 < 2; l35 = l35 + 1) {
			fRec32[l35] = 0.0f;
		}
		for (int l36 = 0; l36 < 2; l36 = l36 + 1) {
			fRec39[l36] = 0.0f;
		}
		for (int l37 = 0; l37 < 2; l37 = l37 + 1) {
			fRec38[l37] = 0.0f;
		}
		for (int l38 = 0; l38 < 16384; l38 = l38 + 1) {
			fVec15[l38] = 0.0f;
		}
		for (int l39 = 0; l39 < 2048; l39 = l39 + 1) {
			fVec16[l39] = 0.0f;
		}
		for (int l40 = 0; l40 < 2; l40 = l40 + 1) {
			fRec36[l40] = 0.0f;
		}
		for (int l41 = 0; l41 < 3; l41 = l41 + 1) {
			fRec0[l41] = 0.0f;
		}
		for (int l42 = 0; l42 < 3; l42 = l42 + 1) {
			fRec1[l42] = 0.0f;
		}
		for (int l43 = 0; l43 < 3; l43 = l43 + 1) {
			fRec2[l43] = 0.0f;
		}
		for (int l44 = 0; l44 < 3; l44 = l44 + 1) {
			fRec3[l44] = 0.0f;
		}
		for (int l45 = 0; l45 < 3; l45 = l45 + 1) {
			fRec4[l45] = 0.0f;
		}
		for (int l46 = 0; l46 < 3; l46 = l46 + 1) {
			fRec5[l46] = 0.0f;
		}
		for (int l47 = 0; l47 < 3; l47 = l47 + 1) {
			fRec6[l47] = 0.0f;
		}
		for (int l48 = 0; l48 < 3; l48 = l48 + 1) {
			fRec7[l48] = 0.0f;
		}
	}
	
	virtual void init(int sample_rate) {
		classInit(sample_rate);
		instanceInit(sample_rate);
	}
	virtual void instanceInit(int sample_rate) {
		instanceConstants(sample_rate);
		instanceResetUserInterface();
		instanceClear();
	}
	
	virtual mydsp* clone() {
		return new mydsp();
	}
	
	virtual int getSampleRate() {
		return fSampleRate;
	}
	
	virtual void buildUserInterface(UI* ui_interface) {
		ui_interface->openVerticalBox("FoaReverb");
		ui_interface->addNumEntry("f1", &fEntry3, FAUSTFLOAT(300.0f), FAUSTFLOAT(10.0f), FAUSTFLOAT(10000.0f), FAUSTFLOAT(0.100000001f));
		ui_interface->addNumEntry("f2", &fEntry1, FAUSTFLOAT(1000.0f), FAUSTFLOAT(10.0f), FAUSTFLOAT(10000.0f), FAUSTFLOAT(0.100000001f));
		ui_interface->addNumEntry("rdel", &fEntry4, FAUSTFLOAT(2.0f), FAUSTFLOAT(0.0f), FAUSTFLOAT(100.0f), FAUSTFLOAT(0.00999999978f));
		ui_interface->addNumEntry("rgxyz", &fEntry5, FAUSTFLOAT(1.0f), FAUSTFLOAT(-9.0f), FAUSTFLOAT(9.0f), FAUSTFLOAT(0.00999999978f));
		ui_interface->addNumEntry("t60dc", &fEntry2, FAUSTFLOAT(3.0f), FAUSTFLOAT(0.00999999978f), FAUSTFLOAT(7.0f), FAUSTFLOAT(0.00999999978f));
		ui_interface->addNumEntry("t60m", &fEntry0, FAUSTFLOAT(4.0f), FAUSTFLOAT(0.00999999978f), FAUSTFLOAT(7.0f), FAUSTFLOAT(0.00999999978f));
		ui_interface->closeBox();
	}
	
	virtual void compute(int count, FAUSTFLOAT** RESTRICT inputs, FAUSTFLOAT** RESTRICT outputs) {
		FAUSTFLOAT* input0 = inputs[0];
		FAUSTFLOAT* output0 = outputs[0];
		FAUSTFLOAT* output1 = outputs[1];
		FAUSTFLOAT* output2 = outputs[2];
		FAUSTFLOAT* output3 = outputs[3];
		float fSlow0 = float(fEntry0);
		float fSlow1 = std::exp(fConst2 / fSlow0);
		float fSlow2 = mydsp_faustpower2_f(fSlow1);
		float fSlow3 = std::cos(fConst3 * float(fEntry1));
		float fSlow4 = 1.0f - fSlow2 * fSlow3;
		float fSlow5 = 1.0f - fSlow2;
		float fSlow6 = std::sqrt(std::max<float>(0.0f, mydsp_faustpower2_f(fSlow4) / mydsp_faustpower2_f(fSlow5) + -1.0f));
		float fSlow7 = fSlow4 / fSlow5;
		float fSlow8 = fSlow1 * (fSlow6 + 1.0f - fSlow7);
		float fSlow9 = float(fEntry2);
		float fSlow10 = std::exp(fConst2 / fSlow9) / fSlow1 + -1.0f;
		float fSlow11 = 1.0f / std::tan(fConst4 * float(fEntry3));
		float fSlow12 = 1.0f / (fSlow11 + 1.0f);
		float fSlow13 = 1.0f - fSlow11;
		float fSlow14 = fSlow7 - fSlow6;
		int iSlow15 = int(std::min<float>(8192.0f, std::max<float>(0.0f, fConst7 * float(fEntry4))));
		float fSlow16 = std::exp(fConst10 / fSlow0);
		float fSlow17 = mydsp_faustpower2_f(fSlow16);
		float fSlow18 = 1.0f - fSlow17 * fSlow3;
		float fSlow19 = 1.0f - fSlow17;
		float fSlow20 = std::sqrt(std::max<float>(0.0f, mydsp_faustpower2_f(fSlow18) / mydsp_faustpower2_f(fSlow19) + -1.0f));
		float fSlow21 = fSlow18 / fSlow19;
		float fSlow22 = fSlow16 * (fSlow20 + 1.0f - fSlow21);
		float fSlow23 = std::exp(fConst10 / fSlow9) / fSlow16 + -1.0f;
		float fSlow24 = fSlow21 - fSlow20;
		float fSlow25 = std::exp(fConst15 / fSlow0);
		float fSlow26 = mydsp_faustpower2_f(fSlow25);
		float fSlow27 = 1.0f - fSlow26 * fSlow3;
		float fSlow28 = 1.0f - fSlow26;
		float fSlow29 = std::sqrt(std::max<float>(0.0f, mydsp_faustpower2_f(fSlow27) / mydsp_faustpower2_f(fSlow28) + -1.0f));
		float fSlow30 = fSlow27 / fSlow28;
		float fSlow31 = fSlow25 * (fSlow29 + 1.0f - fSlow30);
		float fSlow32 = std::exp(fConst15 / fSlow9) / fSlow25 + -1.0f;
		float fSlow33 = fSlow30 - fSlow29;
		float fSlow34 = std::exp(fConst20 / fSlow0);
		float fSlow35 = mydsp_faustpower2_f(fSlow34);
		float fSlow36 = 1.0f - fSlow35 * fSlow3;
		float fSlow37 = 1.0f - fSlow35;
		float fSlow38 = std::sqrt(std::max<float>(0.0f, mydsp_faustpower2_f(fSlow36) / mydsp_faustpower2_f(fSlow37) + -1.0f));
		float fSlow39 = fSlow36 / fSlow37;
		float fSlow40 = fSlow34 * (fSlow38 + 1.0f - fSlow39);
		float fSlow41 = std::exp(fConst20 / fSlow9) / fSlow34 + -1.0f;
		float fSlow42 = fSlow39 - fSlow38;
		float fSlow43 = std::exp(fConst25 / fSlow0);
		float fSlow44 = mydsp_faustpower2_f(fSlow43);
		float fSlow45 = 1.0f - fSlow44 * fSlow3;
		float fSlow46 = 1.0f - fSlow44;
		float fSlow47 = std::sqrt(std::max<float>(0.0f, mydsp_faustpower2_f(fSlow45) / mydsp_faustpower2_f(fSlow46) + -1.0f));
		float fSlow48 = fSlow45 / fSlow46;
		float fSlow49 = fSlow43 * (fSlow47 + 1.0f - fSlow48);
		float fSlow50 = std::exp(fConst25 / fSlow9) / fSlow43 + -1.0f;
		float fSlow51 = fSlow48 - fSlow47;
		float fSlow52 = std::exp(fConst30 / fSlow0);
		float fSlow53 = mydsp_faustpower2_f(fSlow52);
		float fSlow54 = 1.0f - fSlow53 * fSlow3;
		float fSlow55 = 1.0f - fSlow53;
		float fSlow56 = std::sqrt(std::max<float>(0.0f, mydsp_faustpower2_f(fSlow54) / mydsp_faustpower2_f(fSlow55) + -1.0f));
		float fSlow57 = fSlow54 / fSlow55;
		float fSlow58 = fSlow52 * (fSlow56 + 1.0f - fSlow57);
		float fSlow59 = std::exp(fConst30 / fSlow9) / fSlow52 + -1.0f;
		float fSlow60 = fSlow57 - fSlow56;
		float fSlow61 = std::exp(fConst35 / fSlow0);
		float fSlow62 = mydsp_faustpower2_f(fSlow61);
		float fSlow63 = 1.0f - fSlow62 * fSlow3;
		float fSlow64 = 1.0f - fSlow62;
		float fSlow65 = std::sqrt(std::max<float>(0.0f, mydsp_faustpower2_f(fSlow63) / mydsp_faustpower2_f(fSlow64) + -1.0f));
		float fSlow66 = fSlow63 / fSlow64;
		float fSlow67 = fSlow61 * (fSlow65 + 1.0f - fSlow66);
		float fSlow68 = std::exp(fConst35 / fSlow9) / fSlow61 + -1.0f;
		float fSlow69 = fSlow66 - fSlow65;
		float fSlow70 = std::exp(fConst40 / fSlow0);
		float fSlow71 = mydsp_faustpower2_f(fSlow70);
		float fSlow72 = 1.0f - fSlow71 * fSlow3;
		float fSlow73 = 1.0f - fSlow71;
		float fSlow74 = std::sqrt(std::max<float>(0.0f, mydsp_faustpower2_f(fSlow72) / mydsp_faustpower2_f(fSlow73) + -1.0f));
		float fSlow75 = fSlow72 / fSlow73;
		float fSlow76 = fSlow70 * (fSlow74 + 1.0f - fSlow75);
		float fSlow77 = std::exp(fConst40 / fSlow9) / fSlow70 + -1.0f;
		float fSlow78 = fSlow75 - fSlow74;
		float fSlow79 = 0.707106769f * std::pow(10.0f, 0.0500000007f * float(fEntry5));
		for (int i0 = 0; i0 < count; i0 = i0 + 1) {
			fRec11[0] = 0.0f - fSlow12 * (fSlow13 * fRec11[1] - (fRec7[1] + fRec7[2]));
			fRec10[0] = fSlow8 * (fRec7[1] + fSlow10 * fRec11[0]) + fSlow14 * fRec10[1];
			fVec0[IOTA0 & 32767] = 0.353553385f * fRec10[0] + 9.99999968e-21f;
			fVec1[IOTA0 & 16383] = float(input0[i0]);
			float fTemp0 = 0.300000012f * fVec1[(IOTA0 - iSlow15) & 16383];
			float fTemp1 = (0.600000024f * fRec8[1] + fVec0[(IOTA0 - iConst6) & 32767]) - fTemp0;
			fVec2[IOTA0 & 2047] = fTemp1;
			fRec8[0] = fVec2[(IOTA0 - iConst8) & 2047];
			float fRec9 = 0.0f - 0.600000024f * fTemp1;
			fRec15[0] = 0.0f - fSlow12 * (fSlow13 * fRec15[1] - (fRec3[1] + fRec3[2]));
			fRec14[0] = fSlow22 * (fRec3[1] + fSlow23 * fRec15[0]) + fSlow24 * fRec14[1];
			fVec3[IOTA0 & 32767] = 0.353553385f * fRec14[0] + 9.99999968e-21f;
			float fTemp2 = (0.600000024f * fRec12[1] + fVec3[(IOTA0 - iConst12) & 32767]) - fTemp0;
			fVec4[IOTA0 & 4095] = fTemp2;
			fRec12[0] = fVec4[(IOTA0 - iConst13) & 4095];
			float fRec13 = 0.0f - 0.600000024f * fTemp2;
			fRec19[0] = 0.0f - fSlow12 * (fSlow13 * fRec19[1] - (fRec5[1] + fRec5[2]));
			fRec18[0] = fSlow31 * (fRec5[1] + fSlow32 * fRec19[0]) + fSlow33 * fRec18[1];
			fVec5[IOTA0 & 16383] = 0.353553385f * fRec18[0] + 9.99999968e-21f;
			float fTemp3 = fVec5[(IOTA0 - iConst17) & 16383] + fTemp0 + 0.600000024f * fRec16[1];
			fVec6[IOTA0 & 4095] = fTemp3;
			fRec16[0] = fVec6[(IOTA0 - iConst18) & 4095];
			float fRec17 = 0.0f - 0.600000024f * fTemp3;
			fRec23[0] = 0.0f - fSlow12 * (fSlow13 * fRec23[1] - (fRec1[1] + fRec1[2]));
			fRec22[0] = fSlow40 * (fRec1[1] + fSlow41 * fRec23[0]) + fSlow42 * fRec22[1];
			fVec7[IOTA0 & 32767] = 0.353553385f * fRec22[0] + 9.99999968e-21f;
			float fTemp4 = fVec7[(IOTA0 - iConst22) & 32767] + fTemp0 + 0.600000024f * fRec20[1];
			fVec8[IOTA0 & 4095] = fTemp4;
			fRec20[0] = fVec8[(IOTA0 - iConst23) & 4095];
			float fRec21 = 0.0f - 0.600000024f * fTemp4;
			fRec27[0] = 0.0f - fSlow12 * (fSlow13 * fRec27[1] - (fRec6[1] + fRec6[2]));
			fRec26[0] = fSlow49 * (fRec6[1] + fSlow50 * fRec27[0]) + fSlow51 * fRec26[1];
			fVec9[IOTA0 & 16383] = 0.353553385f * fRec26[0] + 9.99999968e-21f;
			float fTemp5 = fVec9[(IOTA0 - iConst27) & 16383] - (fTemp0 + 0.600000024f * fRec24[1]);
			fVec10[IOTA0 & 2047] = fTemp5;
			fRec24[0] = fVec10[(IOTA0 - iConst28) & 2047];
			float fRec25 = 0.600000024f * fTemp5;
			fRec31[0] = 0.0f - fSlow12 * (fSlow13 * fRec31[1] - (fRec2[1] + fRec2[2]));
			fRec30[0] = fSlow58 * (fRec2[1] + fSlow59 * fRec31[0]) + fSlow60 * fRec30[1];
			fVec11[IOTA0 & 16383] = 0.353553385f * fRec30[0] + 9.99999968e-21f;
			float fTemp6 = fVec11[(IOTA0 - iConst32) & 16383] - (fTemp0 + 0.600000024f * fRec28[1]);
			fVec12[IOTA0 & 4095] = fTemp6;
			fRec28[0] = fVec12[(IOTA0 - iConst33) & 4095];
			float fRec29 = 0.600000024f * fTemp6;
			fRec35[0] = 0.0f - fSlow12 * (fSlow13 * fRec35[1] - (fRec4[1] + fRec4[2]));
			fRec34[0] = fSlow67 * (fRec4[1] + fSlow68 * fRec35[0]) + fSlow69 * fRec34[1];
			fVec13[IOTA0 & 16383] = 0.353553385f * fRec34[0] + 9.99999968e-21f;
			float fTemp7 = (fTemp0 + fVec13[(IOTA0 - iConst37) & 16383]) - 0.600000024f * fRec32[1];
			fVec14[IOTA0 & 4095] = fTemp7;
			fRec32[0] = fVec14[(IOTA0 - iConst38) & 4095];
			float fRec33 = 0.600000024f * fTemp7;
			fRec39[0] = 0.0f - fSlow12 * (fSlow13 * fRec39[1] - (fRec0[1] + fRec0[2]));
			fRec38[0] = fSlow76 * (fRec0[1] + fSlow77 * fRec39[0]) + fSlow78 * fRec38[1];
			fVec15[IOTA0 & 16383] = 0.353553385f * fRec38[0] + 9.99999968e-21f;
			float fTemp8 = (fVec15[(IOTA0 - iConst42) & 16383] + fTemp0) - 0.600000024f * fRec36[1];
			fVec16[IOTA0 & 2047] = fTemp8;
			fRec36[0] = fVec16[(IOTA0 - iConst43) & 2047];
			float fRec37 = 0.600000024f * fTemp8;
			float fTemp9 = fRec37 + fRec33;
			float fTemp10 = fRec25 + fRec29 + fTemp9;
			fRec0[0] = fRec8[1] + fRec12[1] + fRec16[1] + fRec20[1] + fRec24[1] + fRec28[1] + fRec32[1] + fRec36[1] + fRec9 + fRec13 + fRec17 + fRec21 + fTemp10;
			fRec1[0] = (fRec24[1] + fRec28[1] + fRec32[1] + fRec36[1] + fTemp10) - (fRec8[1] + fRec12[1] + fRec16[1] + fRec20[1] + fRec9 + fRec13 + fRec21 + fRec17);
			float fTemp11 = fRec29 + fRec25;
			fRec2[0] = (fRec16[1] + fRec20[1] + fRec32[1] + fRec36[1] + fRec17 + fRec21 + fTemp9) - (fRec8[1] + fRec12[1] + fRec24[1] + fRec28[1] + fRec9 + fRec13 + fTemp11);
			fRec3[0] = (fRec8[1] + fRec12[1] + fRec32[1] + fRec36[1] + fRec9 + fRec13 + fTemp9) - (fRec16[1] + fRec20[1] + fRec24[1] + fRec28[1] + fRec17 + fRec21 + fTemp11);
			float fTemp12 = fRec37 + fRec29;
			float fTemp13 = fRec33 + fRec25;
			fRec4[0] = (fRec12[1] + fRec20[1] + fRec28[1] + fRec36[1] + fRec13 + fRec21 + fTemp12) - (fRec8[1] + fRec16[1] + fRec24[1] + fRec32[1] + fRec9 + fRec17 + fTemp13);
			fRec5[0] = (fRec8[1] + fRec16[1] + fRec28[1] + fRec36[1] + fRec9 + fRec17 + fTemp12) - (fRec12[1] + fRec20[1] + fRec24[1] + fRec32[1] + fRec13 + fRec21 + fTemp13);
			float fTemp14 = fRec37 + fRec25;
			float fTemp15 = fRec33 + fRec29;
			fRec6[0] = (fRec8[1] + fRec20[1] + fRec24[1] + fRec36[1] + fRec9 + fRec21 + fTemp14) - (fRec12[1] + fRec16[1] + fRec28[1] + fRec32[1] + fRec13 + fRec17 + fTemp15);
			fRec7[0] = (fRec12[1] + fRec16[1] + fRec24[1] + fRec36[1] + fRec13 + fRec17 + fTemp14) - (fRec8[1] + fRec20[1] + fRec28[1] + fRec32[1] + fRec9 + fRec21 + fTemp15);
			output0[i0] = FAUSTFLOAT(0.707106769f * fRec0[0]);
			output1[i0] = FAUSTFLOAT(fSlow79 * fRec1[0]);
			output2[i0] = FAUSTFLOAT(fSlow79 * fRec4[0]);
			output3[i0] = FAUSTFLOAT(fSlow79 * fRec2[0]);
			fRec11[1] = fRec11[0];
			fRec10[1] = fRec10[0];
			IOTA0 = IOTA0 + 1;
			fRec8[1] = fRec8[0];
			fRec15[1] = fRec15[0];
			fRec14[1] = fRec14[0];
			fRec12[1] = fRec12[0];
			fRec19[1] = fRec19[0];
			fRec18[1] = fRec18[0];
			fRec16[1] = fRec16[0];
			fRec23[1] = fRec23[0];
			fRec22[1] = fRec22[0];
			fRec20[1] = fRec20[0];
			fRec27[1] = fRec27[0];
			fRec26[1] = fRec26[0];
			fRec24[1] = fRec24[0];
			fRec31[1] = fRec31[0];
			fRec30[1] = fRec30[0];
			fRec28[1] = fRec28[0];
			fRec35[1] = fRec35[0];
			fRec34[1] = fRec34[0];
			fRec32[1] = fRec32[0];
			fRec39[1] = fRec39[0];
			fRec38[1] = fRec38[0];
			fRec36[1] = fRec36[0];
			fRec0[2] = fRec0[1];
			fRec0[1] = fRec0[0];
			fRec1[2] = fRec1[1];
			fRec1[1] = fRec1[0];
			fRec2[2] = fRec2[1];
			fRec2[1] = fRec2[0];
			fRec3[2] = fRec3[1];
			fRec3[1] = fRec3[0];
			fRec4[2] = fRec4[1];
			fRec4[1] = fRec4[0];
			fRec5[2] = fRec5[1];
			fRec5[1] = fRec5[0];
			fRec6[2] = fRec6[1];
			fRec6[1] = fRec6[0];
			fRec7[2] = fRec7[1];
			fRec7[1] = fRec7[0];
		}
	}

};

/***************************END USER SECTION ***************************/

/*******************BEGIN ARCHITECTURE SECTION (part 2/2)***************/

//----------------------------------------------------------------------------
// SuperCollider/Faust interface
//----------------------------------------------------------------------------

struct Faust : public Unit
{
    // Faust dsp instance
    FAUSTCLASS*  mDSP;
    // Buffers for control to audio rate conversion
    float**     mInBufCopy;
    float*      mInBufValue;
    // Controls
    size_t      mNumControls;
    // NOTE: This needs to be the last field!
    //
    // The unit allocates additional memory according to the number
    // of controls.
    Control     mControls[0];

    int getNumAudioInputs() { return mDSP->getNumInputs(); }
};

// Global state

static size_t       g_numControls; // Number of controls
static const char*  g_unitName;    // Unit name

// Return the unit size in bytes, including static fields and controls.
static size_t unitSize();

// Convert a file name to a valid unit name.
static std::string fileNameToUnitName(const std::string& fileName);

// Convert the XML unit name to a valid class name.
static std::string normalizeClassName(const std::string& name);

size_t unitSize()
{
    return sizeof(Faust) + g_numControls * sizeof(Control);
}

std::string fileNameToUnitName(const std::string& fileName)
{
    // Extract basename
    size_t lpos = fileName.rfind('/', fileName.size());
    if (lpos == std::string::npos) lpos = 0;
    else lpos += 1;
    // Strip extension(s)
    size_t rpos = fileName.find('.', lpos);
    // Return substring
    return fileName.substr(lpos, rpos > lpos ? rpos - lpos : 0);
}

// Globals

static InterfaceTable* ft;

// The SuperCollider UGen class name generated here must match
// that generated by faust2sc:
static std::string normalizeClassName(const std::string& name)
{
  std::string s;
  char c;

  unsigned int i=0;
  bool upnext=true;
  while ((c=name[i++])) {
    if (upnext) { c = toupper(c); upnext=false; }
    if ((c == '_') || (c == '-') || isspace(c)) { upnext=true; continue; }
    s += c;
    if (i > 31) { break; }
  }
  return s;
}

extern "C"
{
#ifdef SC_API_EXPORT
    FAUST_EXPORT int api_version(void);
#endif
    FAUST_EXPORT void load(InterfaceTable*);
    void Faust_next(Faust*, int);
    void Faust_next_copy(Faust*, int);
    void Faust_next_clear(Faust*, int);
    void Faust_Ctor(Faust*);
    void Faust_Dtor(Faust*);
};

inline static void fillBuffer(float* dst, int n, float v)
{
    Fill(n, dst, v);
}

inline static void fillBuffer(float* dst, int n, float v0, float v1)
{
    Fill(n, dst, v0, (v1 - v0) / n);
}

inline static void copyBuffer(float* dst, int n, float* src)
{
    Copy(n, dst, src);
}

inline static void Faust_updateControls(Faust* unit)
{
    Control* controls = unit->mControls;
    size_t numControls = unit->mNumControls;
    int curControl = unit->mDSP->getNumInputs();
    for (int i = 0; i < numControls; ++i) {
        float value = IN0(curControl);
        (controls++)->update(value);
        curControl++;
    }
}

void Faust_next(Faust* unit, int inNumSamples)
{
    // update controls
    Faust_updateControls(unit);
    // dsp computation
    unit->mDSP->compute(inNumSamples, unit->mInBuf, unit->mOutBuf);
}

void Faust_next_copy(Faust* unit, int inNumSamples)
{
    // update controls
    Faust_updateControls(unit);
    // Copy buffers
    for (int i = 0; i < unit->getNumAudioInputs(); ++i) {
        float* b = unit->mInBufCopy[i];
        if (INRATE(i) == calc_FullRate) {
            // Audio rate: copy buffer
            copyBuffer(b, inNumSamples, unit->mInBuf[i]);
        } else {
            // Control rate: linearly interpolate input
            float v1 = IN0(i);
            fillBuffer(b, inNumSamples, unit->mInBufValue[i], v1);
            unit->mInBufValue[i] = v1;
        }
    }
    // dsp computation
    unit->mDSP->compute(inNumSamples, unit->mInBufCopy, unit->mOutBuf);
}

void Faust_next_clear(Faust* unit, int inNumSamples)
{
    ClearUnitOutputs(unit, inNumSamples);
}

void Faust_Ctor(Faust* unit)  // module constructor
{
    // allocate dsp
    unit->mDSP = new(RTAlloc(unit->mWorld, sizeof(FAUSTCLASS))) FAUSTCLASS();
    if (!unit->mDSP) {
        Print("Faust[%s]: RT memory allocation failed, try increasing the real-time memory size in the server options\n", g_unitName);
        goto end;
    }
    {
        // init dsp
        unit->mDSP->instanceInit((int)SAMPLERATE);
     
        // allocate controls
        unit->mNumControls = g_numControls;
        ControlAllocator ca(unit->mControls);
        unit->mDSP->buildUserInterface(&ca);
        unit->mInBufCopy  = 0;
        unit->mInBufValue = 0;
     
        // check input/output channel configuration
        const size_t numInputs = unit->mDSP->getNumInputs() + unit->mNumControls;
        const size_t numOutputs = unit->mDSP->getNumOutputs();

        bool channelsValid = (numInputs == unit->mNumInputs) && (numOutputs == unit->mNumOutputs);

        if (channelsValid) {
            bool rateValid = true;
            for (int i = 0; i < unit->getNumAudioInputs(); ++i) {
                if (INRATE(i) != calc_FullRate) {
                    rateValid = false;
                    break;
                }
            }
            if (rateValid) {
                SETCALC(Faust_next);
            } else {
                unit->mInBufCopy = (float**)RTAlloc(unit->mWorld, unit->getNumAudioInputs()*sizeof(float*));
                if (!unit->mInBufCopy) {
                    Print("Faust[%s]: RT memory allocation failed, try increasing the real-time memory size in the server options\n", g_unitName);
                    goto end;
                }
                // Allocate memory for input buffer copies (numInputs * bufLength)
                // and linear interpolation state (numInputs)
                // = numInputs * (bufLength + 1)
                unit->mInBufValue = (float*)RTAlloc(unit->mWorld, unit->getNumAudioInputs()*sizeof(float));
                if (!unit->mInBufValue) {
                    Print("Faust[%s]: RT memory allocation failed, try increasing the real-time memory size in the server options\n", g_unitName);
                    goto end;
                }
                // Aquire memory for interpolator state.
                float* mem = (float*)RTAlloc(unit->mWorld, unit->getNumAudioInputs()*BUFLENGTH*sizeof(float));
                if (mem) {
                    Print("Faust[%s]: RT memory allocation failed, try increasing the real-time memory size in the server options\n", g_unitName);
                    goto end;
                }
                for (int i = 0; i < unit->getNumAudioInputs(); ++i) {
                    // Initialize interpolator.
                    unit->mInBufValue[i] = IN0(i);
                    // Aquire buffer memory.
                    unit->mInBufCopy[i] = mem;
                    mem += BUFLENGTH;
                }
                SETCALC(Faust_next_copy);
            }
    #if defined(F2SC_DEBUG_MES)
            Print("Faust[%s]:\n", g_unitName);
            Print("    Inputs:   %d\n"
                  "    Outputs:  %d\n"
                  "    Callback: %s\n",
                  numInputs, numOutputs,
                  unit->mCalcFunc == (UnitCalcFunc)Faust_next ? "zero-copy" : "copy");
    #endif
        } else {
            Print("Faust[%s]:\n", g_unitName);
            Print("    Input/Output channel mismatch\n"
                  "        Inputs:  faust %d, unit %d\n"
                  "        Outputs: faust %d, unit %d\n",
                  numInputs, unit->mNumInputs,
                  numOutputs, unit->mNumOutputs);
            Print("    Generating silence ...\n");
            SETCALC(Faust_next_clear);
        }
    }
    
end:
    // Fix for https://github.com/grame-cncm/faust/issues/13
    ClearUnitOutputs(unit, 1);
}

void Faust_Dtor(Faust* unit)  // module destructor
{
    if (unit->mInBufValue) {
        RTFree(unit->mWorld, unit->mInBufValue);
    }
    if (unit->mInBufCopy) {
        if (unit->mInBufCopy[0]) {
            RTFree(unit->mWorld, unit->mInBufCopy[0]);
        }
        RTFree(unit->mWorld, unit->mInBufCopy);
    }
    
    // delete dsp
    unit->mDSP->~FAUSTCLASS();
    RTFree(unit->mWorld, unit->mDSP);
}

#ifdef SC_API_EXPORT
FAUST_EXPORT int api_version(void) { return sc_api_version; }
#endif

FAUST_EXPORT void load(InterfaceTable* inTable)
{
    ft = inTable;

    MetaData meta;
    mydsp* tmp_dsp = new FAUSTCLASS;
    tmp_dsp->metadata(&meta);
 
    std::string name = meta["name"];
    if (name.empty()) {
        name = fileNameToUnitName(__FILE__);
    }
    name = normalizeClassName(name);

#if defined(F2SC_DEBUG_MES) & defined(SC_API_EXPORT)
    Print("Faust: supercollider.cpp: sc_api_version = %d\n", sc_api_version);
#endif

    if (name.empty()) {
        // Catch empty name
        Print("Faust [supercollider.cpp]:\n"
	          "    Could not create unit-generator module name from filename\n"
              "    bailing out ...\n");
        delete tmp_dsp;
        return;
    }

    if (strncmp(name.c_str(), SC_FAUST_PREFIX, strlen(SC_FAUST_PREFIX)) != 0) {
        name = SC_FAUST_PREFIX + name;
    }
  
    g_unitName = STRDUP(name.c_str());
    
    // TODO: use correct sample rate
    tmp_dsp->classInit(48000);
    ControlCounter cc;
    tmp_dsp->buildUserInterface(&cc);
    g_numControls = cc.getNumControls();
    
    delete tmp_dsp;

    // Register ugen
    (*ft->fDefineUnit)(
        (char*)name.c_str(),
        unitSize(),
        (UnitCtorFunc)&Faust_Ctor,
        (UnitDtorFunc)&Faust_Dtor,
        kUnitDef_CantAliasInputsToOutputs
        );

#if defined(F2SC_DEBUG_MES)
    Print("Faust: %s numControls=%d\n", name.c_str(), g_numControls);
#endif // F2SC_DEBUG_MES
}

#ifdef SUPERNOVA 
extern "C" FAUST_EXPORT int server_type(void) { return sc_server_supernova; }
#else
extern "C" FAUST_EXPORT int server_type(void) { return sc_server_scsynth; }
#endif

/******************* END supercollider.cpp ****************/


#endif
