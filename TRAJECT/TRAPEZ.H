

	#ifndef _TRAPEZ_H
	#define _TRAPEZ_H
	#endif

	#ifndef _DATATYPE_H
	#include "datatype.h"
	#endif

	#ifndef _TRAJECT_H
	#include "traject.h"
	#endif


	class	Trapez : public Trajectory
	{
		protected:
			BOOL	m_ComputePosition( void );
			BOOL	m_ComputeSpeed( void );
			BOOL	m_ComputeAcceleration( void );
			float	m_ComputeTrajectoryTime( void );
			BOOL	m_ComputeLambda( void );


		public:

			Trapez(  void ); 			// Constructor ...
			~Trapez( void );			// Destructor  ...

	};
